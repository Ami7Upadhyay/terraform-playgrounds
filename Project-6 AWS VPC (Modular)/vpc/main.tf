# Custom VPC

# 2 public subnets

# 2 private subnets

# Internet Gateway

# NAT Gateway

# Route tables

# Reusable Terraform module

// create vpc
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {"name" : var.vpc_name}
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = {"name": "${var.vpc_name}-igw"}
}

// create two public subnet
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidr)
  vpc_id = aws_vpc.this.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = var.availability_zone[count.index]
  map_public_ip_on_launch = true
  tags = {"name": "${var.vpc_name}-public-subnet-${count.index + 1}"}
}


resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidr)
    vpc_id = aws_vpc.this.id
    cidr_block = var.public_subnet_cidr[count.index]
    availability_zone = var.availability_zone[count.index]
    
    tags = {
      "name": "${var.vpc_name}-private_subnet-${count.index + 1}"
    }
}


resource "aws_eip" "nat" {
  count = length(var.public_subnet_cidr)
}

resource "aws_nat_gateway" "this" {
  count         = length(var.public_subnet_cidr)
  subnet_id     = aws_subnet.public[count.index].id
  allocation_id = aws_eip.nat[count.index].id

  depends_on = [aws_internet_gateway.this]

  tags = {
    Name = "${var.vpc_name}-nat-${count.index + 1}"
  }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.this.id
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = aws_internet_gateway.this.id
        }
  
  tags = {"name": "${var.vpc_name}-public_rt"}
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr)
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  count  = length(aws_nat_gateway.this)

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.this[count.index].id
  }

  tags = {
    Name = "${var.vpc_name}-private-rt-${count.index + 1}"
  }
}


resource "aws_route_table_association" "private" {
    count = length(var.private_subnet_cidr)
    subnet_id = aws_subnet.private[count.index].id
   route_table_id = aws_route_table.private[count.index].id
}