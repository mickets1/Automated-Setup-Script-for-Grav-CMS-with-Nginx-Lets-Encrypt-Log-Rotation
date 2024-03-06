# This Ansible playbook automates the setup process for deploying a Grav CMS website with Nginx as the web server, Let's Encrypt for SSL certificate generation, and log rotation to manage Nginx logs efficiently.

## Features:
    Automated Setup: Quickly deploy a Grav CMS website on your Ubuntu server with minimal manual configuration using Ansible.
    Nginx Configuration: Customize Nginx configuration to optimize performance and security.
    Let's Encrypt SSL: Automatically obtain SSL certificates from Let's Encrypt for secure HTTPS connections.
    Log Rotation: Manage Nginx log files efficiently by rotating logs based on size to prevent them from growing too large.
    Scheduled Tasks: Schedule periodic tasks for pushing Nginx logs to GitHub and exporting system resource information.

## Usage:
    Clone this repository to your Ansible control node.
    Customize the variables in the playbook to match your setup (e.g., GitHub repository, Grav site name, domain).
    Run the playbook to automate the setup process:


## Run in server:
ansible-playbook setup.yaml

## Requirements:
    Ansible installed on your control node.
    Ubuntu server with SSH access and sudo privileges.