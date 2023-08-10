#!/bin/bash

cd /home/ubuntu

# Add PostgreSQL repository to sources.list
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Import PostgreSQL repository key
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Update package list
sudo apt-get update

# Install PostgreSQL
sudo apt-get -y install postgresql

# PostgreSQL username and password
db_user="postgres"
db_password="password"
db_name="lmsdb"

# Create a new PostgreSQL user and database
sudo -u postgres psql -c "CREATE USER $db_user WITH PASSWORD '$db_password';"
sudo -u postgres psql -c "CREATE DATABASE $db_name;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $db_name TO $db_user;"

echo "PostgreSQL installation and user/database creation completed."
