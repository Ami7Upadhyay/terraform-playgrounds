terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.21.0"
    }
  }

  backend "s3" {
    bucket = "terraform-state-remote-backend-bucket1618"
    key = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-state-table"
  }
}