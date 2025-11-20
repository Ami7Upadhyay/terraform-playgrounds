variable "vpc_cidr" {
  description = "CIDR block for VPC"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
}

variable "availability_zone" {
  description = "AWS availability zone"
}

variable "vpc_name" {
  description = "VPC name tag"
}
