1. Install AWS Cli in server/local machine

click below link
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

2. Install Terraform

click below link
https://developer.hashicorp.com/terraform/downloads

3. Create IAM user 
Goto AWS portal
Goto IAM service
Create IAM User 
Add Admin Access policy to and others if required
Goto User list and click on it
Create Access-Key and Secret-Key

4. Terraform Initialization

mkdir terraform    ( optional workspace name)
give provider details in provider.tf

Main commands:
  terraform init  ------Prepare your working directory for other commands
  terraform validate ---Check whether the configuration is valid
  terraform fmt --------Reformat your configuration in the standard style
  terraform plan   -----Show changes required by the current configuration
  terraform apply  -----Create or update infrastructure
  terraform destroy  --- Destroy previously-created infrastructure


5. Create Resources


