variable "environment" {
  type        = string
  description = "The environment type (dev or prod)"
  default     = "eben-staging"
}

variable "aws_region" {
  type        = string
  description = "AWS region for resources"
  default     = "eu-west-2"
}

variable "instance_count" {
  type = number
  description = "instance count for resources"
  default = 3
}

variable "allowed_regions" {
  description = "List of allowed AWS regions"
  type        = list(string)
  default     = ["us-east-1", "us-west-2", "eu-west-1", "ap-south-1"]
}


variable "ingress_rules" {
  description = "List of ingress rules for security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTP"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "HTTPS"
    }
  ]
}
