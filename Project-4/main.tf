# ☁️ Intermediate Level – Modular Infrastructure
# 🧱 Project 4: Modular VPC + EC2 Deployment

# Goal: Split your code into reusable modules.
# Concepts:

# Terraform modules
# Variable files and outputs

# Module sourcing (local or remote)
# Practice Tasks:

# Create a vpc module
# Create an ec2 module
# Main root configuration to call both modules
# 🧠 Outcome: Learn modularization and structure for large projects.


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.6.0"
}

provider "aws" {
  region = var.aws_region
}

data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
      name = "name"
      values = [ "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*" ]
    }

    owners = ["099720109477"] # Canonical
  
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  availability_zone   = var.availability_zone
  vpc_name            = "Modular-VPC"
}

module "ec2" {
  source         = "./modules/ec2"
  ami_id         = data.aws_ami.ubuntu.id
  instance_type  = var.instance_type
  subnet_id      = module.vpc.public_subnet_id
  vpc_id         = module.vpc.vpc_id
  instance_name  = "Modular-EC2"
}
