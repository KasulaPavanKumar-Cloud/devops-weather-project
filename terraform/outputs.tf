output "instance_public_ip" {
  description = "Public IP of the devops host"
  value       = aws_instance.devops_host.public_ip
}

output "instance_public_dns" {
  description = "Public DNS"
  value       = aws_instance.devops_host.public_dns
}
