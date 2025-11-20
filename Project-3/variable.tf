variable "aws-region" {
  default = "ap-south-1"
}

variable "vpc-cidr" {
  default = "10.0.0.0/16"
  description = "Custom VPC"
}

variable "subnet-cidr" {
  default = "10.0.0.0/24"
}