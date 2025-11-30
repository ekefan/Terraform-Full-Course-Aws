terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.16.0"
    }
  }
}

# provider "aws" {
#   region = contains(var.allowed_region, var.region)

#   default_tags {
#     tags = {
#       Project     = "Terraform-Full-Course-AWS"
#       Day         = "07"
#       Topic       = "Type-Constraints"
#       ManagedBy   = "Terraform"
#       Environment = var.environment
#     }
#   }
# }



provider "aws" {
  region = var.config.region
  profile = var.credential_profile

  default_tags {
    tags = {
      Project     = "Terraform-Full-Course-AWS"
      Day         = "07"
      Topic       = "Type-Constraints"
      ManagedBy   = "Terraform"
      Environment = var.environment
    }
  }
}
