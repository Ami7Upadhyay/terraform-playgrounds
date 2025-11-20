output "ec2-public-ip" {
  value = [
    for key in aws_instance.ec2 : key.public_ip
  ]
}