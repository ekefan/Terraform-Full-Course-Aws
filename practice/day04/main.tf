terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "terraform-state-1764317914"
    key          = "dev/terraform.tfstate"
    region       = "eu-west-3"
    use_lockfile = true
    encrypt      = true
    profile      = "friction-eben-cli"
  }
}

provider "aws" {
    region = "eu-west-3"
    profile = "friction-eben-cli"
}


resource "aws_s3_bucket" "test_backend" {
  bucket = "test-remote-backend-${random_string.bucket_suffix.result}"

  tags = {
    Name        = "Test Backend Bucket"
    Environment = "dev"
  }
}

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}
