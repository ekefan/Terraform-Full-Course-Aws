variable "project_name" {
  default = "Project ALPHA Resource"
}

variable "default_tags" {
  default = {
    company    = "TechCorp"
    managed_by = "terraform"
  }
}

variable "environment_tags" {
  default = {
    environment = "production"
    cost_center = "cc-123"
  }
}

variable "bucket_name" {
  default = "ProjectAlphaStorageBucket with CAPS and spaces!!!"
}

variable "allowed_ports" {
  default = "80,443,8080,3306"
}

variable "instance_sizes" {
  default = {
    dev     = "t2.micro"
    staging = "t3.small"
    prod    = "t3.large"
  }
}

variable "environment" {
    default = "dev"
    type = string
}

variable "instance_type" {
  default = "t2.micro"
  
  validation {
    condition     = length(var.instance_type) >= 2 && length(var.instance_type) <= 20
    error_message = "Instance type must be between 2 and 20 characters"
  }
  
  validation {
    condition     = can(regex("^t[2-3]\\.", var.instance_type))
    error_message = "Instance type must start with t2 or t3"
  }
}

variable "backup_name" {
  default = "daily_backup"
  
  validation {
    condition     = endswith(var.backup_name, "_backup")
    error_message = "Backup name must end with '_backup'"
  }
}

variable "credential" {
  default   = "xyz123"
  sensitive = true
}

variable "user_locations" {
  default = ["us-east-1", "us-west-2", "us-east-1"]  # Has duplicate
}

variable "default_locations" {
  default = ["us-west-1"]
}

variable "monthly_costs" {
  default = [-50, 100, 75, 200]  # -50 is a credit
}