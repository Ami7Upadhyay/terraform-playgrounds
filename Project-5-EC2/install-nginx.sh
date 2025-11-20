#!/bin/bash
apt-get update -y
apt-get install nginx -y
systemctl start nginx
systemctl enable nginx
echo "<h1>Hello, this page was created with Terraform</h1>" > /var/www/html/index.html
