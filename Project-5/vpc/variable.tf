
variable "region" {
  default = "ap-south-1"
}

variable "vpc-cidr_block" {
  description = "vpc cidr block"
  # default = "10.0.0.0/16"
}

variable "public-subnet-cidr_block" {
  description = "public subnet  cidr block"
  # default = "10.0.1.0/24"
}

variable "private-subnet-cidr-cidr_block" {
  description = "private subnet  cidr block"
  # default = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "availability_zone"
}

variable "vpc-name" {
  description = "vpc name"
}

output "security_group_id" {
  value = aws_security_group.sg.id
}