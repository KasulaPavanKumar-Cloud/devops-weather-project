provider "aws" {
  region = var.aws_region
}

# Security group
resource "aws_security_group" "devops_sg" {
  name        = "devops-sg"
  description = "Allow SSH, Jenkins, SonarQube, Prometheus, Grafana, HTTP and NodePort range"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  ingress {
    description = "SonarQube"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  ingress {
    description = "Prometheus"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  ingress {
    description = "Grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  # Kubernetes NodePort range (if you use NodePort later)
  ingress {
    description = "K8s NodePort range"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-sg"
  }
}

# Use default VPC
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default_subnets" {
  vpc_id = data.aws_vpc.default.id
}

# Pick first subnet
locals {
  subnet_id = data.aws_subnet_ids.default_subnets.ids[0]
}

# EC2 instance
resource "aws_instance" "devops_host" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = local.subnet_id
  key_name      = var.pavankey
  security_groups = [aws_security_group.devops_sg.id]

  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "devops-host"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

