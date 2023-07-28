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
terraform init

5. Create Resources

terraform fmt —-----------it will show new/untracked files
terraform plan ----------it will show which resources will going to change
terraform apply --yes —----it will create resources
terraform destroy - -yes —------it will destroy/delete the resources
