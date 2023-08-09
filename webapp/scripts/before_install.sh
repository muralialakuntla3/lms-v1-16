#!/bin/bash
cd /home/ubuntu
curl -fsSL https://rpm.nodesource.com/setup_16.x | sudo bash -
sudo apt-get install -y nodejs
sudo apt install nginx -y
sudo systemctl start nginx
