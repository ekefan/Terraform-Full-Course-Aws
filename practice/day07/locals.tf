locals {
  common_tags = {
    Environment = var.environment
    Project     = "Terraform-Demo"
    Owner       = "DevOps-Team"
  }

  full_bucket_name = "${var.environment}-${var.bucket_name}-${random_string.suffix.result}"
}