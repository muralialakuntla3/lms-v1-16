
# LMS-AWS-PIPELINE 
### STAGES:
1. Create IAM role for EC2 and AWS Code Deploy
2. Launch an EC2 instance and configure it
3. Code deploy
4. Create Code pipeline using Github, Code build 
5. Access your Application on EC2

## Step -1: Create IAM role for EC2 and AWS Code Deploy
    1. IAM role for EC2 ---  policies --- AmazonS3ReadOnlyAccess
    2. IAM role for AWS Code Deploy ---- policies-- AWSCodeDeploy

## Step-2: Launch an EC2 instance and configure it

    name: aws-pipeline
    AMI: ubuntu 20.04
    Instance Type: t2.micro
    key: 9-key.pem
    Network:
        vpc: default
        subnet: default
        public-ip: enable
        Security Group: lms-aws-pipeline (ports: 22, 80, 443, 5432, 3000, ) 
    Configure Storage:
        root Volume: 10 gb
        other volume: optional

 #### Attach IAM role to it

  To install the CodeDeploy agent on Ubuntu Server
  For Ubuntu
    https://docs.aws.amazon.com/codedeploy/latest/userguide/codedeploy-agent-operations-install-ubuntu.html

  Sign in to the instance.
#### Enter the following commands, one after the other
    1: sudo apt update
    2: sudo apt install ruby-full
    3: sudo apt install wget
    4: cd /home/ubuntu
    5: wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install
    6: chmod +x ./install
    7: sudo ./install auto
    8: sudo service codedeploy-agent start
    9: sudo service codedeploy-agent status

## Step-3 : Code Deploy

  ### Goto application and create
    Name:lms
    Compute platform:ec2

  ### Create deployment group
    Group name: lms-grp
    Service role: code deploy role
    Deployment type: in-place
    env config: ec2 instance (name: aws-pipeline)
    no load balancer
  #### click create deployment

## Step-4 : Create Code pipeline using Github, Code build 
CI/CD pipeline stages:

  ### Goto code pipeline

   #### Step 1: CodePipeline
        service role
        new service role
        click next

   #### Step 2: Code Source (CodeCommit or Github)
        Sourse: github (version 2)
        Hit/click: connect github
        Repo: lms-app
        Branch: aws-ci/cd
        click next

   #### Step 3: CodeBuild and Build Specification (buildspec.yaml) File
        Build provider: AWS code build
        Regiaon: Asia pasific (Mumbai)
        Project name: lms-build-fe/be (Create Project first)
            project name: lms-build-fe/be
            Environment: buildspec
            webapp/buildspec.yml or api/buildspec.yml

   #### Step 4: CodeDeploy and Application Specification (appspec.yml ) File
        Deploy provider: AWS code deploy
        Regiaon: Asia pasific (Mumbai)
        Application name: lms
        deployment group: lms-grp

   #### Step 5: Review
        stage-1
        stage-2
        stage-3
        stage-4
   #### click create pipeline

#### check pipeline for output

## step-5: Access your Application on EC2
    
  #### Browse EC2 instance Public-ip:80 or domain name
  #### Browse EC2 instance Public-ip:3000/api  for backend checking

## don't forget to delete below resources once over
    EC2 instance
    code deploy
        application
    code pipeline
        code build
    connections-github
    S3 bucket--empty--delete
    IAM
        Roles
        Policies--custom


