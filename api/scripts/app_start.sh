#!/bin/bash

# Change to your application directory
sudo npm install pm2 -g
sudo npx prisma db push
sudo npm run build
# Start the application with PM2
NODE_PORT=3000 pm2 start -i 0 build/src/index.js
