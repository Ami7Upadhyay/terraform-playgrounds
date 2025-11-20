variable "ami_id" {
  description = "AMI ID for EC2 instance"
}

variable "instance_type" {
  description = "EC2 instance type"
}

variable "subnet_id" {
  description = "Subnet where instance will be launched"
}

variable "vpc_id" {
  description = "VPC ID for the security group"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
}
