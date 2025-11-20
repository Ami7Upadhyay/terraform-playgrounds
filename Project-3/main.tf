
provider "aws" {
  region = var.aws-region
}

data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
      name = "name"
      values = [ "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*" ]
    }

    owners = ["099720109477"] # Canonical
  
}


resource "aws_vpc" "vpc-1" {
  cidr_block = var.vpc-cidr
  tags = {
    "Name" : "MY VPC"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-1.id
}

resource "aws_subnet" "subnet-1" {
  vpc_id = aws_vpc.vpc-1.id
  cidr_block = var.subnet-cidr
  map_public_ip_on_launch  = true
  availability_zone = "ap-south-1a"


  tags = {
    "Name" : "My Subnet"
  }
}

resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.vpc-1.id

  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "route-table-associations" {
  route_table_id = aws_route_table.route-table.id
  subnet_id =  aws_subnet.subnet-1.id
}


resource "aws_security_group" "sgp" {
  name = "my-security-grp"
  description = "custom security grp"
  vpc_id = aws_vpc.vpc-1.id

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    "Name" : "EC2 Security Grop"
  }

}

resource "aws_instance" "app-server" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.sgp.id]
  subnet_id = aws_subnet.subnet-1.id

  associate_public_ip_address = true

  tags = {
    "Name" : "Terraform"
  }
}
