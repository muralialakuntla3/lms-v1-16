# LMS-Minikube-Deployment
## Minikube Installation
Guide - https://minikube.sigs.k8s.io/docs/start/

### Requirements 
1: 2 CPUs or more
2: 2GB of free memory
3: 20GB of free disk space
4: Internet connection
5: Container or virtual machine manager, such as: Docker, Hyperkit, Hyper-V, KVM, Parallels, Podman, VirtualBox, or VMware Fusion/Workstation
6: Use t2.medium instance with 30 GB EBS Volume

### Install Docker
#### visit: get.docker.com 
1: curl -fsSL https://get.docker.com -o install-docker.sh
2: sudo sh install-docker.sh
3: sudo usermod -aG docker ubuntu
4: newgrp docker
5: logout or  exit
6: Relogin
#### Start Docker
1: sudo systemctl enable docker
2: sudo systemctl start docker

## Minikube Setup

1: curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
2: sudo install minikube-linux-amd64 /usr/local/bin/minikube
3: minikube status

### Start Minikube
1: minikube start 
2: minikube status
## MiniKube cluster creation
##### Create first cluster named lms
minikube start -p lms
#### Switch between the clusters:
1: switch to cluster lms
2: minikube profile lms

## Kubectl setup

1: visit: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
2: curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
3: chmod +x kubectl 
4: sudo mv kubectl /usr/local/bin/kubectl
5: kubectl version

## Deploy k8s declarative files

#### Lms code : https://github.com/muralialakuntla3/lms-app.git
### Step 1: database
1: Kubectl apply -f database-persistent-volume-claim.yml
2: Kubectl apply -f db-cluster-ip-service.yml
3: Kubectl apply -f db-deployment.yml

### Step 2: backend
#### Note: Update db pod-ip in api-deployment.yml in
1: env: 
- name: DATABASE_URL
  value: postgresql://postgres:password@100.96.2.221:5432/postgres
2: Kubectl apply -f api-deployment.yml
3: Kubectl apply -f api-lb-service.yml
4: Check: External-ip:3000/api in browser

### Step 3: frontend
#### Note : build frontend with new External-ip:3000/api of api-lb-service.yml in .env

1: Kubectl apply -f web-deployment.yml
2: Kubectl apply -f web-lb-service.yml

## For stoping cluster—------minikube stop
