resource "aws_s3_bucket" "remote-s3" {
  bucket = "terraform-state-remote-backend-bucket1618"

  tags = {"Name": "Terraform Remote BackEnd"}
}