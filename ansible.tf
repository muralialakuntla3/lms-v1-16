# Ansible web Node
resource "aws_instance" "lmsweb" {
  ami           = "ami-08e5424edfe926b43"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.lms-pub-sn.id
  key_name = "9-key"
  vpc_security_group_ids = [aws_security_group.lms-sg.id]
  user_data = file("install_ansible.sh")
  private_ip = "10.0.1.11"

  root_block_device {
    volume_size           = "10"
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "lms web"
  }
}

# Ansible api Node
resource "aws_instance" "lmsapi" {
  ami           = "ami-08e5424edfe926b43"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.lms-pvt-sn.id
  key_name = "9-key"
  vpc_security_group_ids = [aws_security_group.lms-sg.id]
  private_ip = "10.0.2.11"
  root_block_device {
    volume_size           = "10"
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "lms api"
  }
}
