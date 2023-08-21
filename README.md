# lms-app k8s producttion cluster deployment

## Launch workstation
    1. Install Docker and Java —slave for pipeline
    2. Install Jenkins and Java —-jenkins master
    3. Install unzip
    4. Install AWS CLI
    5. Install KOPS
    6. Install kubectl
    7. Create and Attach IAM role
    8. Create S3 bucket
    9. Create 2 node cluster
    10. Deploy k8s declarative files
    11. Delete k8s cluster
## 1. Install Docker
    Visit : https://get.docker.com/

    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    sudo groupadd docker
    sudo usermod -aG docker ubuntu
    newgrp docker
## 2. Install Jenkins and Java
### Java installation
    sudo apt install openjdk-11* -y

### Jenkins installation 

    Visit : https://www.jenkins.io/doc/book/installing/linux/#debianubuntu

    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \https://pkg.jenkins.io/debian-stable binary/ | sudo tee \ /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install jenkins

## 3. Install unzip tool
    Sudo apt install unzip
## 4. Install AWS CLI
    Visit : https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions

    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install

## 5. Install KOPS
    Visit : https://kops.sigs.k8s.io/getting_started/install/

    curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
    chmod +x kops
    sudo mv kops /usr/local/bin/kops


## 6. Install kubectl
    Visit : https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux


    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/kubectl

## 7. Create and Attach IAM role
### To create an IAM role using the IAM console
    - Open the IAM console at https://console.aws.amazon.com/iam/.
    - In the navigation pane, choose Roles, Create role.
    - On the Select role type page, choose EC2 and the EC2 use case. Choose Next: Permissions.
    - On the Attach permissions policy page, select an AWS managed policy AdministratorAccess that grants your instances access to the resources that they need.
    - On the Review page, enter a name for the role and choose Create role.
### Attach an IAM role to an instance
    - To attach an IAM role to an instance that has no role, the instance can be in the stopped or running state.
    - To attach an IAM role to an instance
    - Open the Amazon EC2 console at https://console.aws.amazon.com/ec2/.
    - In the navigation pane, choose Instances.
    - Select the instance, choose Actions, Security, Modify IAM role.
    - Select the IAM role to attach to your instance, and choose Save.
## 8. Create and delete S3 bucket
    aws s3 ls 
    aws s3 mb s3://lms-k8s-cluster
    aws s3 rb s3://lms-k8s-cluster --force
## 9. Create 2 node cluster
    - ssh-keygen ----Generate SSH key for logging into master node
    - kops get cluster
    - kops create cluster --yes --state=s3://lms-k8s-cluster --zones=ap-south-1b,ap-south-1c --node-count=2 --name=lms.k8s.local
    - kops validate cluster --state=s3://lms-k8s-cluster -----for cluster checkup wether it is healthy or not
## 10. Deploy k8s declarative files

Lms code : https://github.com/muralialakuntla3/lms-app.git
### Step 1:
    Kubectl apply -f database-persistent-volume-claim.yml
    Kubectl apply -f db-cluster-ip-service.yml
    Kubectl apply -f db-deployment.yml
### Step 2:

    Note: Update db pod-ip in api-deployment.yml in
    env: 
    - name: DATABASE_URL
    value: postgresql://postgres:password@100.96.2.221:5432/postgres


    Kubectl apply -f api-deployment.yml
    Kubectl apply -f api-lb-service.yml
    Check: External-ip:3000/api in browser
### Step 3:


    Note : build frontend with new External-ip:3000/api of api-lb-service.yml in .env


    Kubectl apply -f web-deployment.yml
    Kubectl apply -f web-lb-service.yml

## 11. Delete k8s cluster

    kops delete cluster --state=s3://lms-k8s-cluster --name=lms.k8s.local --yes 