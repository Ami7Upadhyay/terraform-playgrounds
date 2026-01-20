variable "vpc_cidr" {
  description = "vpc cidr block"
  type = string
}

variable "public_subnet_cidr" {
  type = list(string)
}

variable "private_subnet_cidr" {
  type = list(string)
}

variable "availability_zone" {
  type = list(string)
}

variable "vpc_name" {
  type = string
}