Automated Setup Script for Grav CMS with Nginx, Let's Encrypt SSL, and Log Rotation

This script automates the setup process for deploying a Grav CMS website with Nginx as the web server, Let's Encrypt for SSL certificate generation, and log rotation to manage Nginx logs efficiently.
Features:

    Automated Setup: Quickly deploy a Grav CMS website on your Ubuntu server with minimal manual configuration directly from Github.
    Nginx Configuration: Customizable Nginx configuration to optimize performance and security.
    Let's Encrypt SSL: Automatically obtain SSL certificates from Let's Encrypt for secure HTTPS connections.
    Log Rotation: Manage Nginx log files efficiently by rotating logs based on size to prevent them from growing too large.
    Scheduled Tasks: Schedule periodic tasks for pushing Nginx logs to GitHub and exporting system resource information.

Usage:

    Clone this repository to your Ubuntu server.
    Customize the variables in the script to match your setup (e.g., GitHub repository, Grav site name, domain).
    Run the script to automate the setup process:
    ./setup.sh