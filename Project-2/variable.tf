variable "aws-region" {
  default = "ap-south-1"
}

variable "vpc-cidr-block" {
  default     = "10.0.0.0/16"
  description = "CIDR Block for the VPC"
}

variable "public-subnet-cidr-block" {
  default     = "10.0.0.0/24"
  description = "public CIDR Block for SUBNET"
}

variable "private-subnet-cidr-block" {
  default     = "10.0.1.0/24"
  description = "Private Subnet CIDR Block"
}