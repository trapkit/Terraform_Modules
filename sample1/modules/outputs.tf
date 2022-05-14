
# Print Instance IP
output "EC2_instance_ip_addr" {
  value       = aws_instance.test-pub-EC2.public_ip
  description = "The public IP address of the main server instance."
}

output "EC2-private__ip_addr" {
  value       = aws_instance.test-pr-EC2.private_ip
  description = "The public IP address of the main server instance."
}

# Print instance ID
output "instance" {
  value = aws_instance.test-pub-EC2.id
}

# Print VPC ID 
output "vpc_id" {
  value = aws_vpc.my-vpc.id
}

# Print Public Subnet ID
output "public_subnet_id" {
  value = "aws_subnet.public.id"
}

# Print Private Subnet ID
output "private_subnet_id" {
  value = "aws_subnet.private.id"
}

# Public subnet CIDR
output "public_subnet_cidr" {
  description = "The public subnet CIDR in your VPC"
  value       = aws_subnet.public.cidr_block
}

# Public subnet CIDR
output "private_subnet_cidr" {
  description = "The private subnet CIDR in your VPC"
  value       = aws_subnet.private.cidr_block
}

# vpc Security group ID
output "Security_group_id" {
  description = "the Security group id in your custom vpc is :"
  value       = aws_security_group.mySG.id
}