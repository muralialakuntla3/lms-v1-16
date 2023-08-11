#!/bin/bash

cd /home/ubuntu

# Check if PostgreSQL is already installed
if ! command -v psql &> /dev/null; then
    echo "PostgreSQL is not installed. Proceeding with installation."

    # Add PostgreSQL repository to sources.list
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

    # Import PostgreSQL repository key
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

    # Update package list
    sudo apt-get update

    # Install PostgreSQL
    sudo apt-get -y install postgresql

    echo "PostgreSQL installation completed."
else
    echo "PostgreSQL is already installed. Skipping installation."
fi

# PostgreSQL username and password
db_user="postgres"
db_password="password"
db_name="lmsdb"

# Check if the database already exists
if sudo -u postgres psql -lqt | cut -d \| -f 1 | grep -qw $db_name; then
    echo "Database '$db_name' already exists. Skipping creation."
else
    # Create a new PostgreSQL user and database
    sudo -u postgres psql -c "CREATE USER $db_user WITH PASSWORD '$db_password';"
    sudo -u postgres psql -c "CREATE DATABASE $db_name;"
    sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $db_name TO $db_user;"

    echo "PostgreSQL user and database creation completed."
fi

