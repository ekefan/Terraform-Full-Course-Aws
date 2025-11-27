terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
      }
    }
    
}
provider "aws" {
    region = "eu-west-2"
    # profile = "friction-eben-cli"
}
resource "aws_s3_bucket" "demo-resource-creation" {
  bucket = "awsterraformpractice-00998877"
  force_destroy = true

  tags = {
    Name        = "My bucket 2.0"
    Environment = "Dev"
  }
}