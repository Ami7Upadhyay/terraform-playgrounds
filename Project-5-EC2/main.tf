
resource "aws_key_pair" "deployer" {
  key_name   = "terraform-key"
  public_key = file("terraform-ec2-key.pub")
}

resource "aws_default_vpc" "default-vpc" {

}

resource "aws_security_group" "aws-sg" {
  name        = "ec2-sg"
  vpc_id      = aws_default_vpc.default-vpc.id
  description = "This is security grp for ec2 instance"

  ingress {
    to_port     = 22
    from_port   = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "trafic for ssh"
  }

  ingress {
    to_port     = 80
    from_port   = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "trafic for http protocol"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "=1"
  }

  tags = {
    "Name" : "terraform-ec2-sg"
  }
}

resource "aws_instance" "ec2" {
  for_each = tomap({
    terraform-ec2-server1 = "t3.micro"
    # terraform-ec2-server2 = "t3.micro"
  })
  key_name        = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.aws-sg.name]
  instance_type   = each.value
  ami             = var.aws-ami
  user_data       = file("install-nginx.sh")
  root_block_device {
    volume_size = var.volume-size
    volume_type = var.volume-type
  }



  tags = {
    "Name" : each.key
  }

}

