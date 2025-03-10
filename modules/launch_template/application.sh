#!/bin/bash 
# Update package list and install required packages 
sudo yum update -y 
sudo yum install -y git 

# Install Node.js (use NodeSource for the latest version) 
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash - 
sudo yum install -y nodejs 

# Install PM2 globally 
sudo npm install -g pm2 

# Define variables 
REPO_URL="https://github.com/learnItRightWay01/react-node-mysql-app.git" 
BRANCH_NAME="feature/add-logging" 
REPO_DIR="/home/ec2-user/react-node-mysql-app/backend" 
ENV_FILE="$REPO_DIR/.env" 

# Clone the repository 
cd /home/ec2-user 
sudo -u ec2-user git clone $REPO_URL 
cd react-node-mysql-app  

# Checkout to the specific branch 
sudo -u ec2-user git checkout $BRANCH_NAME 
cd backend 

# Define the log directory and ensure it exists 
LOG_DIR="/home/ec2-user/react-node-mysql-app/backend/logs" 
mkdir -p $LOG_DIR 
sudo chown -R ec2-user:ec2-user $LOG_DIR

# Append environment variables to the .env file
echo "LOG_DIR=$LOG_DIR" >> "$ENV_FILE"
echo "DB_HOST=\"terraform-20250308024532116300000001.cxau0au24i3b.ap-southeast-1.rds.amazonaws.com\"" >> "$ENV_FILE"
echo "DB_PORT=\"3306\"" >> "$ENV_FILE"
echo "DB_USER=\"admin\"" >> "$ENV_FILE"
echo "DB_PASSWORD=\"912005za\"" >> "$ENV_FILE"  # Replace with actual password
echo "DB_NAME=\"react_node_app\"" >> "$ENV_FILE"

# Install Node.js dependencies as ec2-user
sudo -u ec2-user npm install

# Start the application using PM2 as ec2-user
sudo -u ec2-user npm run serve

# Ensure PM2 restarts on reboot as ec2-user
sudo -u ec2-user pm2 startup systemd 
sudo -u ec2-user pm2 save 