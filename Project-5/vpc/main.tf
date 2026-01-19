resource "aws_vpc" "vpc" {
  cidr_block = var.vpc-cidr_block
  tags = {
    "Name" : var.vpc-name
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zone
  cidr_block        = var.public-subnet-cidr_block
  tags = {
    "Name" : "${var.vpc-name}-public-subnet"
  }
}

resource "aws_subnet" "private-subnet" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zone
  cidr_block        = var.private-subnet-cidr-cidr_block
  tags = {
    "Name" : "${var.vpc-name}-Private Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" : "${var.vpc-name}-IGW"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id

  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = { "Name" : "${var.vpc-name}-Pulic Route Table" }
}

resource "aws_route_table_association" "public-route-table-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet.id
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc.id
  tags   = { "Name" : "${var.vpc-name}-Private Route Table" }
}

resource "aws_route_table_association" "private-route-table-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private-subnet.id
}

output "vpc-output" {
  value = aws_vpc.vpc.id
}


resource "aws_security_group" "sg" {
  name = "iac-sg"
  vpc_id = aws_vpc.vpc.id
  description = "this is aws infrastructure code sg"

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

}