locals {
  # Transform "Project ALPHA Resource" to "project-alpha-resource"
  formatted_project_name = lower(replace(var.project_name, " ", "-"))
}


data "aws_vpc" "shared" {
  filter {
    name   = "tag:Name"
    values = ["shared-network-vpc"]
  }
}

data "aws_subnet" "shared" {
  filter {
    name   = "tag:Name"
    values = ["shared-primary-subnet"]
  }
  vpc_id = data.aws_vpc.shared.id
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "main" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.shared.id
  private_ip    = "10.0.1.50"

  tags = {
    Name = "day13-instance"
  }
}