# Custom VPC

# 2 public subnets

# 2 private subnets

# Internet Gateway

# NAT Gateway

# Route tables

# Reusable Terraform module



module "vpc" {
  source              = "./vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidr = ["10.0.101.0/24", "10.0.102.0/24"]
  availability_zone   = ["ap-south-1a", "ap-south-1b"]
  vpc_name            = "module_vpc"
}