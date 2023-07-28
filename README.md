1. Install AWS Cli in server
sudo apt install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

2. Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt install terraform
terraform --version

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
