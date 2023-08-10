#!/bin/bash

cd /home/ubuntu

# Check if Node.js is already installed
if command -v node &>/dev/null; then
    echo "Node.js is already installed. Skipping installation."
    exit 0
fi

# Update package list
sudo apt update

# Install necessary dependencies
sudo apt install -y curl

# Download and install Node.js 16
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt install -y nodejs

# Verify Node.js and npm installation
node -v
npm -v

echo "Node.js 16 installation completed."
