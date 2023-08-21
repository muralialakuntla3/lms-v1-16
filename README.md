# CI/CD FOR LMS REACT APPLICATION
## Prerequisites
    > WGET
    > GIT
    > JAVA 11
    > JENKINS
    > DOCKER           	
## Brief review about  project
    1. We need to two instance one for master (jenkins) and Slave (docker container)
    2. Docker installed in  slave  Server(ubuntu)
    3. Jenkins as Master in server (ubuntu)
    4. In Docker slave server install docker, java11 and create a docker network with name lmsnetwork
    5. In Jenkins Master server configure node as docker server as slave
    6. In Jenkins server create pipeline backend pipeline  and test backend it should be up and running.
    7. Once the backend is running Update the backend url in frontend in frontend /webapp .env file.
    8. Now create a Frontend pipeline .

## Step 1: launch 2 servers
   ### SERVER SETUP:
    -  	Instance type-t2 medium
    -  	Os-ubuntu-20.04
    -  	Security ports to be opened
    443, 5432(for database) ,80 ,  8080,3000
## Step 2: Configuration of Docker server
  ### Install docker
    www.get.docker.com
    Installation commands
    curl -fsSL https://get.docker.com -o install-docker.sh
    sudo sh install-docker.sh 
    Adding docker group
    sudo usermod -aG docker ubuntu
    newgrp docker
    Starting Docker Service
    sudo systemctl start docker
    Enabling Docker Service
    sudo systemctl enable docker
  
## Step 3:Installing Jenkins server 
    www.jenkins.io
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
      /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
      https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
      /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install jenkins 
    login to Jenkins server and install suggested plugins 
## Step 4: Configuring Docker slave server
    Now add user
    Creating  docker network
    docker network create -d bridge lmsnetwork
    Note : In slave  install Java 11 as Jenkins required
    sudo apt install openjdk-11* -y
## Step 5: configure node as docker server as slave
    configure node:
    Goto Jenkins configurations
    Goto to Node setup
    Add your docker slave details
    Add your docker hub credentials:
    Goto Jenkins configurations
    Goto Manage credentials
    Configure docker hub credentials 
    Done with configuration of master and slave
    Now create a Job (pipeline job) in Jenkins
## Step 6: Now configuring Backend pipeline
    Now create a jenkins file that is 
    lms-app/api/Jenkinsfile in your github repository
### Jenkins file
    pipeline {
        agent {
        node {
            label 'docker-slave'
             }
            }
        environment {
        dockerhub=credentials('dockerhub')
        }
        stages{
            stage('Docker Build') { 
                steps {
                    sh 'cd api && docker build -t muralialakuntla3/api .'
                 }
              }
            stage('Docker remove container') {  
                steps {
                    sh 'docker container rm -f api2'
                }
              }
            stage('Docker run container') { 
                steps {
                    sh 'docker container run -dt --name api2 -p 3000:3000 muralialakuntla3/api'
                }
              }
            stage('Docker Login') { 
                steps {
                    sh 'echo $dockerhub_PSW | docker login -u $dockerhub_USR --password-stdin'
                }
              }
            stage('Docker Push') {  
                steps {
                    sh 'docker push muralialakuntla3/api'
                }
              }
            stage('Remove old docker images') {
                steps {
                    sh 'docker rmi -f muralialakuntla3/api'
                  }
              }
            stage('creating database container') {
                steps {
                    sh 'docker container rm --force lmsdb'
                    sh 'docker run -d -p 5432:5432 --network lms-appnetwork -e POSTGRES_PASSWORD=password --name lmsdb postgres'
                    }
               }
            stage('Running the docker container') {
                steps {
                    sh 'docker container rm --force api2'
                    sh 'docker run -d -p 3000:3000 --network lms-appnetwork -e DATABASE_URL=postgresql://postgres:password@lmsdb:5432/postgres --name api2 -e PORT=3000 -e MODE=local muralialakuntla3/api'
                    }
                  }
            }
      }
## Step 7: Update the backend url in frontend
    Build the Backend pipeline then update the url of backend in frontend
    at /webapp/.env file
    Now test the backend server
    Backend is up and running Now
    End of backend configuration
## Step 8: Deploying Frontend
 
    Now Create FrontEnd pipeline in jenkins  after updating of backend url in webapp .
    
    Note : to build frontend our backend should be up and running .
     
    Now add jenkins files at in frontend /webapp/name of jenkinsfile
     
### Jenkinsfile for frontend
 
    pipeline {
    	agent {
      	label 'docker'
    	}
    	environment {
    	DOCKERHUB_CREDENTIALS = credentials('dockerusermubeen')
     	registry = "mubeen507/frontend-lms"
        	registryCredential = 'dockerhub'
    	} 
    	stages {    	
        	stage('Building the docker image') {
            	steps {
                	sh 'cd webapp && docker build -t mubeen507/frontend-lms .'
            	}
        	}
        	stage('Logging into dockerhub account') {
            	steps {
                	sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            	}
        	}
        	stage('pushing the docker image into dockerhub') {
            	steps {
                  	sh 'docker push mubeen507/frontend-lms'
            	}
        	}
        	stage('Remove old docker images') {
             	steps {
                 	sh 'docker rmi -f mubeen507/frontend-lms'
            	}
        	}
         	stage('Running the docker container') {
            	steps {
                  	sh 'docker container rm --force fe'
                  	sh 'docker run -dt -p 8000:80 --name fe mubeen507/frontend-lms'
            	}
        	}
    	}
    }

#### Update user credential of  docker user (example dockeruser )jenkinsfile
 
#### Now Build frontend pipeline
  
    And set your dockerhubusername/imagename
    
    Note : Update URL of Backend in .env of webapp (as webapp is you frontend) before building application.
    
    For Example backend is running on 54.183.228:8080/api
    Note : update the Backend url in FrontEnd webapp .env
     
    Creating of frontend pipeline
    Provide the git repository
    Provide the jenkinsfile location
 
