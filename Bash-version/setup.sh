#!/bin/bash

# Define variables
github_repo="yourusername/your-grav-repo"
grav_site="your-grav-site"
nginx_conf="/path/to/your/nginx.conf"
logrotate_conf="/path/to/your/nginx_logrotate"
log_dir="/var/log/nginx"
log_push_script="/usr/local/bin/push_logs.sh"
resource_info_script="/usr/local/bin/export_resource_info.sh"
resource_info_log="/path/to/resource_info.log"
domain="your-domain.com"

# Function to push logs to GitHub
push_logs_to_github() {
    cd "$log_dir" || exit
    git add .
    git commit -m "Update Nginx logs"
    git push origin master
}

# Function to export system resource information
export_resource_info() {
    top -bn1 > "$resource_info_log"
}

# Update package lists
sudo apt update

# Install necessary packages
sudo apt install -y git nginx php-fpm php-cli php-curl php-zip php-gd php-mbstring php-xml

# Clone Grav CMS repository from GitHub
git clone "https://github.com/$github_repo.git" "/var/www/html/$grav_site"

# Copy custom nginx.conf to /etc/nginx/nginx.conf
sudo cp "$nginx_conf" /etc/nginx/nginx.conf

# Add FastCGI parameter for security
echo 'fastcgi_param  HTTP_PROXY         "";' | sudo tee -a /etc/nginx/fastcgi.conf

# Obtain SSL certificate using Let's Encrypt
sudo apt install -y certbot python3-certbot-nginx
sudo certbot --nginx -d "$domain" -d www."$domain"

# Adjust PHP settings for Grav CMS
sudo sed -i 's/memory_limit = .*/memory_limit = 512M/' /etc/php/7.4/fpm/php.ini
sudo sed -i 's/max_execution_time = .*/max_execution_time = 300/' /etc/php/7.4/fpm/php.ini

# Adjust file permissions
sudo chown -R www-data:www-data "/var/www/html/$grav_site"
sudo find "/var/www/html/$grav_site" -type d -exec chmod 755 {} \;
sudo find "/var/www/html/$grav_site" -type f -exec chmod 644 {} \;

# Restart services
sudo systemctl restart nginx php7.4-fpm

# Copy logrotate configuration for Nginx logs
sudo cp "$logrotate_conf" /etc/logrotate.d/nginx

# Schedule log pushing to GitHub and exporting resource information using cron
(crontab -l 2>/dev/null; echo "0 0 * * * $log_push_script") | crontab -
(crontab -l 2>/dev/null; echo "0 0 * * * $resource_info_script") | crontab -

# Create a script to push logs to GitHub
sudo tee "$log_push_script" > /dev/null <<EOF
#!/bin/bash

# Change directory to Nginx logs
cd "$log_dir" || exit

# Add, commit, and push logs to GitHub
git add .
git commit -m "Update Nginx logs"
git push origin master
EOF

# Create a script to export resource information
sudo tee "$resource_info_script" > /dev/null <<EOF
#!/bin/bash

# Export system resource information
top -bn1 > "$resource_info_log"
EOF

# Make the scripts executable
sudo chmod +x "$log_push_script" "$resource_info_script"

# Run the functions to push logs to GitHub and export resource information immediately
push_logs_to_github
export_resource_info
