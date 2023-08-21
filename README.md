# lms-app Sonar analysis


## Server Required
  	**Ubuntu 20 server** 
  	**T3.2xlarge**
  	**30GB**
## Install Jenkins and Java
### Java installation
    sudo apt install openjdk-11* -y

### Jenkins installation 

    - Visit : https://www.jenkins.io/doc/book/installing/linux/#debianubuntu
    
    - curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    - echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
                    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
                      /etc/apt/sources.list.d/jenkins.list > /dev/null
    - sudo apt-get update
    - sudo apt-get install jenkins

## install Node ( for Building application)
  
  	curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash - 
  	sudo apt-get install -y nodejs
   	node -v

## Install Docker
    	www.get.docker.com    
    	curl -fsSL https://get.docker.com -o install-docker.sh    
    	sudo sh install-docker.sh

### Adding permissions

  	sudo usermod â€“aG docker ubuntu
  	newgrp docker
## creating the sonar container
	  sudo docker container run -dt --name sonarqube -p 9000:9000 sonarqube
### Default credentials admin & admin
    **Generate the  token for sonarqube update the token url projectkey in jekins file**  
## Adding permission to  Jenkins user by adding jenkins in sudoers file
  ### Sudo visudo
    add **jenkins ALL=(ALL) NOPASSWD: ALL**
    save it by **ctrl + X and press enter**
    Restart the Jenkins make it affect 
    sudo systemctl restart Jenkins
    **Run the pipeline  To analyze the code**


