# LMS deployment using Terraform-Ansible

   #### 1. Setup Workstation
   #### 2. Create IAM user and generate Access & Secret Keys
   #### 3. Terraform Initialization
   #### 4. Create VPC
   #### 5. Create Firewalls
   #### 6. Create servers
   #### 7. Setup Ansible master
## 1. Setup Workstation
### Install aws cli

    - sudo apt install unzip
    - Visit : https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions

    - curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    - unzip awscliv2.zip
    - sudo ./aws/install
    - Test: /usr/local/bin/aws --version
### Install Terraform
    - Visit: https://developer.hashicorp.com/terraform/downloads
    - sudo apt-get update
    
    - wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    
    - echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    
    - sudo apt install terraform
    - Test: terraform -version

### Clone the repo
    git clone -b terraform https://muralialakuntla3-admin@bitbucket.org/muralialakuntla3/lms-app.git
### Terraform Main commands:
    - terraform init  ------Prepare your working directory for other commands
    - terraform validate ---Check whether the configuration is valid
    - terraform fmt --------Reformat your configuration in the standard style
    - terraform plan   -----Show changes required by the current configuration
    - terraform apply  -----Create or update infrastructure
    - terraform destroy  --- Destroy previously-created infrastructure

## 2. Create IAM user and generate Access & Secret Keys
    - Create IAM user 
    - Goto AWS portal 
    - Goto IAM service 
    - Click on Create IAM User 
    - Add Admin Access policy to and others if required 
    - Goto User list and click on it 
    - Create Access-Key and Secret-Key
    - Store them for future use

## 3. Terraform Initialization
    - mkdir terraform    ( optional workspace name)
    - Create provider.tf file
    - give provider details in provider.tf
		
### AWS provider
    provider "aws" {
    region     = "ap-south-1"
    access_key = "***************"
    secret_key = "***********************"
    }
## 4. Create VPC
### VPC COMPONENTS
#### vpc.tf
    - VPC
    - PUBLIC SUBNET
    - PRIVATE SUBNET
    - INTERNET GATEWAY
    - PUBLIC Route Table
    - PRIVATE Route Table
    - SUBNET - ROUTE TABLE ASSOCIATION - PUBLIC
    - SUBNET - ROUTE TABLE ASSOCIATION - PRIVATE
    - AWS ELASTIC IP
    - AWS NAT GATEWAY

## 5. Create Firewalls
### firewall.tf
    - ingress rules
    - egress rules
## 6. Create servers Server.tf / ansible.tf
    Ansible Master Server 
    Ansible web Node/Server
    Ansible api Node/Server

## 7. Setup Ansible master
### Login to ansible master
    > sudo apt-get update
    > Install ansible : sudo apt install -y ansible
    > Copy the key file (which is used while launching the node servers) from your local system to your master
        - scp -i <key of user> <the file/key you want send> user@public-ip:<destination path>
        - Scp -i amk.pem index.txt ubuntu@o.o.o.o:/home/ubuntu/
### Check the hosts:
    ansible –list-hosts all -i aws.ini
### Check connection status:
    ansible -m ping all -i aws.ini
### create the play books:
    Lmsweb.yml
    lmsapi.yml
### Run the playbooks:
    ansible-playbook lmsweb.yml -i aws.ini
    ansible-playbook lmsapi.yml -i aws.ini

