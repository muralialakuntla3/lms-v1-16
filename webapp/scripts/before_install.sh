#!/bin/bash
cd /home/ubuntu

# Check if Node.js is already installed
if command -v node &>/dev/null; then
    echo "Node.js is already installed. Skipping installation."
    exit 0
fi

curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt install nginx -y
sudo systemctl start nginx
