variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "pavankey" {
  description = "Name of an existing AWS EC2 KeyPair to use for SSH access"
  type        = string
}

variable "allowed_cidr" {
  description = "CIDR block allowed to access management ports (SSH, Jenkins etc.)"
  type        = string
  default     = "0.0.0.0/0"
}
