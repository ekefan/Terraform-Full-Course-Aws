resource "aws_s3_bucket" "lifecycle_example" {
  bucket = "tf-day08-lifecycle-${var.environment}-20251017-nueje"
  force_destroy = true
  lifecycle {
    create_before_destroy = true
    prevent_destroy = false
  }

  tags = {
    Name        = "Lifecycle Example"
    Environment = var.environment
    ManagedBy   = "terraform"
    CreatedDate = "2025-10-17"
  }
}


resource "aws_launch_template" "foobar" {
  name_prefix   = "foobar"
  image_id      = "ami-1a2b3c"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "app_servers" {
  max_size = 3
  min_size = 2
  desired_capacity = 2
  launch_template {
    id      = aws_launch_template.foobar.id
    version = "$Latest"
  }

  lifecycle {
    ignore_changes = [
      desired_capacity,
      load_balancers,
    ]
  }
}

resource "aws_security_group" "app_sg" {
    name = "practice-app-security-group"

}

resource "aws_instance" "app_with_sg" {
    instance_type = "t2.micro"
    ami = "ami-005e54dee72cc1d00"
    vpc_security_group_ids = [aws_security_group.app_sg.id]

    lifecycle {
      replace_triggered_by = [ aws_security_group.app_sg.id ]
    }
}

resource "aws_s3_bucket" "regional_validation" {
  bucket = "validated-region-bucket"

  lifecycle {
    precondition {
      condition     = contains(var.allowed_regions, data.aws_region.current.name)
      error_message = "ERROR: Can only deploy in allowed regions: ${join(", ", var.allowed_regions)}"
    }
  }
}

resource "aws_s3_bucket" "compliance_bucket" {
  bucket = "compliance-bucket"

  tags = {
    Environment = "production"
    Compliance  = "SOC2"
  }

  lifecycle {
    postcondition {
      condition     = contains(keys(self.tags), "Compliance")
      error_message = "ERROR: Bucket must have a 'Compliance' tag!"
    }

    postcondition {
      condition     = contains(keys(self.tags), "Environment")
      error_message = "ERROR: Bucket must have an 'Environment' tag!"
    }
  }
}