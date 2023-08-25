
# VPC ---65536 ip's
resource "aws_vpc" "lms-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "lms vpc"
  }
}

# PUBLIC SUBNET---256 ip's
resource "aws_subnet" "lms-pub-sn" {
  vpc_id     = aws_vpc.lms-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "lms public subnet"
  }
}

# PRIVATE SUBNET---256 ip's
resource "aws_subnet" "lms-pvt-sn" {
  vpc_id     = aws_vpc.lms-vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "lms private subnet"
  }
}
# AWS ELASTIC IP
resource "aws_eip" "lms-eip" {
  vpc      = true
  tags = {
    Name = "lms eip"
  }
}

# AWS NAT GATEWAY
resource "aws_nat_gateway" "lms-nat" {
  allocation_id = aws_eip.lms-eip.id
  subnet_id     = aws_subnet.lms-pub-sn.id

  tags = {
    Name = "NAT GW"
  }

  depends_on = [aws_internet_gateway.lms-igw] 
}
# INTERNET GATEWAY
resource "aws_internet_gateway" "lms-igw" {
  vpc_id = aws_vpc.lms-vpc.id

  tags = {
    Name = "lms igw"
  }
}


# PUBLIC RT
resource "aws_route_table" "lms-pub-rt" {
  vpc_id = aws_vpc.lms-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lms-igw.id
  }

  tags = {
    Name = "lms public rt"
  }
}


# PRIVATE RT
resource "aws_route_table" "lms-pvt-rt" {
  vpc_id = aws_vpc.lms-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.lms-nat.id
  }

  tags = {
    Name = "lms private rt"
  }
}

# SUBNET - ROUTE TABLE ASSOCIATION - PUBLIC
resource "aws_route_table_association" "lms-pub-asc" {
  subnet_id      = aws_subnet.lms-pub-sn.id
  route_table_id = aws_route_table.lms-pub-rt.id
}

# SUBNET - ROUTE TABLE ASSOCIATION - PRIVATE
resource "aws_route_table_association" "lms-pvt-asc" {
  subnet_id      = aws_subnet.lms-pvt-sn.id
  route_table_id = aws_route_table.lms-pvt-rt.id
}

