provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./vpc"
  vpc-cidr_block =  "10.0.0.0/16"
  public-subnet-cidr_block = "10.0.1.0/24"
  private-subnet-cidr-cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1a"
  vpc-name = "Module VPC"
}

# data "aws_ami" "ubuntu" {
#   most_recent = true
#   owners      = ["099720109477"] # Canonical (official Ubuntu)

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
# }

# resource "aws_instance" "iac_ec2" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t3.micro"

#   vpc_security_group_ids = [module.vpc.security_group_id]

#   tags = {
#     Name = "ubuntu-ec2"
#   }
# }
