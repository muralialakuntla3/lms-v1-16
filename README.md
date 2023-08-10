# LMS-Minikube-Deployment
## Minikube Installation
Guide - https://minikube.sigs.k8s.io/docs/start/

### Requirements 
2 CPUs or more
2GB of free memory
20GB of free disk space
Internet connection
Container or virtual machine manager, such as: Docker, Hyperkit, Hyper-V, KVM, Parallels, Podman, VirtualBox, or VMware Fusion/Workstation
Use t2.medium instance with 30 GB EBS Volume

### Install Docker
> visit: get.docker.com 
> curl -fsSL https://get.docker.com -o get-docker.sh
> sh get-docker.sh
> sudo usermod -aG docker ubuntu
> logout or  exit
> Relogin
#### Start Docker
> sudo systemctl enable docker
> sudo systemctl start docker

## Minikube Setup

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube
minikube status

### Start Minikube
> minikube start 
> minikube status
## MiniKube cluster creation
##### Create first cluster named lms
minikube start -p lms
#### Switch between the clusters:
switch to cluster lms
minikube profile lms

## Kubectl setup

   > kubectl version
   >  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
   >  chmod +x kubectl 
   >  sudo mv kubectl /usr/local/bin/kubectl
   >  kubectl version


## Deploy k8s declarative files

#### Lms code : https://github.com/muralialakuntla3/lms-app.git
### Step 1: database
Kubectl apply -f database-persistent-volume-claim.yml
Kubectl apply -f db-cluster-ip-service.yml
Kubectl apply -f db-deployment.yml

### Step 2: backend
Note: Update db pod-ip in api-deployment.yml in
env: 
- name: DATABASE_URL
  value: postgresql://postgres:password@100.96.2.221:5432/postgres
Kubectl apply -f api-deployment.yml
Kubectl apply -f api-lb-service.yml
Check: External-ip:3000/api in browser

### Step 3: frontend
Note : build frontend with new External-ip:3000/api of api-lb-service.yml in .env

Kubectl apply -f web-deployment.yml
Kubectl apply -f web-lb-service.yml

## For stoping cluster—------minikube stop
