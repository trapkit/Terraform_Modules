# Print Instance IP
output "instance_public_ip" {
  value       = aws_instance.test-pub-EC2.public_ip
  description = "The public IP address of the main server instance."
}

output "instance_private_ip" {
  value       = aws_instance.test-priv-EC2.private_ip
  description = "The public IP address of the main server instance."
}

# Print instance ID
output "public_instance_ID" {
  value = aws_instance.test-pub-EC2.id
}

output "private_instance_ID" {
  value = aws_instance.test-priv-EC2.id
}

