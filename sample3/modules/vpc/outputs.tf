# Print VPC ID 
output "vpc_id" {
  value = aws_vpc.my-vpc.id
}

# Print Public Subnet ID
output "public_subnet_id" {
  value = aws_subnet.public.id
}

# Print Private Subnet ID
output "private_subnet_id" {
  value = aws_subnet.private.id
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

######################  NEW  0000000000000
output "AZ_public" {
  value = aws_subnet.public.availability_zone
}

output "AZ_private" {
  value = aws_subnet.private.availability_zone
}
####################