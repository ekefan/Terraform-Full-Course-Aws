variable "environment" {
  type        = string
  description = "The environment type"
  default     = "eben-staging"
}

variable "aws_region" {
  type        = string
  description = "AWS region for resources"
  default     = "eu-west-2"
}


variable "allowed_regions" {
  description = "List of allowed AWS regions"
  type        = list(string)
  default     = ["us-east-1", "us-west-2", "eu-west-1", "ap-south-1"]
}