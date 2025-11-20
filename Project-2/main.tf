# Project 2: Build a Custom VPC

# Goal: Create a custom network environment.
# Concepts:

# aws_vpc, aws_subnet, aws_internet_gateway, aws_route_table

# Dependencies and references

# Practice Tasks:

# One VPC
# One public subnet
# One private subnet
# Internet Gateway for public subnet
# Route Table associations

# 🧠 Outcome: Learn networking and how Terraform manages multiple resources.

provider "aws" {
  region = var.aws-region
}

resource "aws_vpc" "vpc-1" {
  cidr_block = var.vpc-cidr-block
  tags       = { "Name" : "vpc" }
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.vpc-1.id
  cidr_block              = var.public-subnet-cidr-block
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"
  tags                    = { "Name" : "Public Subnet" }
}

resource "aws_subnet" "private-subnet" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = var.private-subnet-cidr-block
  availability_zone = "ap-south-1b"
  tags = {
    "Name" : "Private Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-1.id
  tags = {
    "Name" : "Private Subnet"
  }
}

resource "aws_eip" "elastic-ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "natg" {
  subnet_id     = aws_subnet.public-subnet.id
  allocation_id = aws_eip.elastic-ip.id
  tags = {
    "Name" : "NAT GateWay"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public-route_table-ass" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet.id
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc-1.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natg.id
  }
}


resource "aws_route_table_association" "private-route-table-ass" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private-subnet.id
}

output "vpc_id" {
  value = aws_vpc.vpc-1.id
}

output "public_subnet_id" {
  value = aws_subnet.public-subnet.id
}


output "nat_gateway_id" {
  value = aws_nat_gateway.natg.id
}
