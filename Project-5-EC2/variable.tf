variable "aws-instance-type" {
  default = "t3.micro"
}


variable "aws-ami" {
  default = "ami-02b8269d5e85954ef"
}

variable "volume-size" {
  default = 8
}

variable "volume-type" {
  default = "gp3"
}