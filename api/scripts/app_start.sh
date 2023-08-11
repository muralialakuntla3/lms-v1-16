#!/bin/bash

# Change to your application directory
cd /home/ubuntu/build

# Install PM2 globally
npm install pm2 -g

# Push Prisma database changes
npx prisma db push

# Install dependencies and build the application
npm install
npm run build

# Start the application with PM2
NODE_PORT=3000 pm2 start -i 0 src/index.js
