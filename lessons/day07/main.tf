resource "aws_security_group" "web_sg" {
  name        = "${var.server_config.name}-sg"  # Object type usage
  description = "Security group for web server"
  
  # HTTP access using tuple type (port number from network_config[2])
  ingress {
    from_port   = var.network_config[2]  # Tuple type: third element (number)
    to_port     = var.network_config[2]  # Tuple type: third element (number)
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks  # List type
  }
  
  ingress {
    from_port   = var.ingress_values[0]
    protocol    = var.inggress_values[1]
    to_port     = var.ingress_values[2]
    cidr_blocks = var.allowed_cidr_blocks
  }
  
  # Outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Map type: Tags
  tags = var.instance_tags
}


resource "aws_s3_bucket" "tf_test_baivab_bucket" {
  bucket = "${var.environment}-unique-bucket-001"

  tags = {
    Name        = "My bucket"
    Environment = var.environment
  }
}

resource "aws_instance" "demo_instances" {
  count         = var.instance_count
  ami           = "ami-0e8459476fed2e23b"
  monitoring                  = var.enable_monitoring
  associate_public_ip_address = var.associate_public_ip
}
resource "aws_instance" "task_9" {
  count         = var.config.instance_count
  region = var.config.region
  monitoring = var.config.region
  ami           = "ami-0e8459476fed2e23b"
  associate_public_ip_address = var.associate_public_ip

  lifecycle {
  precondition {
    condition     = contains(var.allowed_vm_types, var.instance_type)
    error_message = "Instance type '${var.instance_type}' is NOT allowed."
  }
  }

  tags = {
    Name = "validated-instance"
  }
}
resource "aws_vpc" "demo_vpc" {
  cidr_block = var.allowed_cidr_blocks[0]

  tags = var.instance_tags
}

resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = var.allowed_cidr_blocks[1]

  tags = {
    Name = "demo-subnet-1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = var.allowed_cidr_blocks[2]

  tags = {
    Name = "demo-subnet-2"
  }
}
