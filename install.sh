# installation of nginx and unzip

sudo apt install nginx -y
Sudo apt install unzip -y
sudo apt install zip -y

# java installation

sudo apt install openjdk-11* -y

# jenkins installation

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins

# docker installation

curl -fsSL https://get.docker.com -o install-docker.sh
sudo sh install-docker.sh
# Adding permissions
sudo usermod –aG docker ubuntu
newgrp docker

# nodejs installation

curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash - 
sudo apt-get install -y nodejs


