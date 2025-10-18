variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the EC2 Key Pair to create"
  type        = string
  default     = "devops-key"
}

variable "allowed_ip" {
  description = "Public IP address range allowed for SSH and HTTP access"
  type        = string
  default     = "0.0.0.0/0"
}
