output "ec2_public_ip" {
  value = aws_instance.devops_ec2.public_ip
  description = "Public IP address of the EC2 instance"
}

output "private_key_path" {
  value       = local_file.private_key_pem.filename
  description = "Path to the generated SSH private key"
}
