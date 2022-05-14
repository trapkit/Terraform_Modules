#####################################################################################################################################
#                                                       VPC outputs
#***********************************************************************************************************************************

# Print VPC ID 
output "vpc_id" {
  #   value = aws_vpc.my-vpc.id
  value = module.ascentt-vpc.vpc_id

}

# Print Public Subnet ID
output "public_subnet_id" {
  #   value = aws_subnet.public.id
  value = module.ascentt-vpc.public_subnet_id
}

# Print Private Subnet ID
output "private_subnet_id" {
  #   value = aws_subnet.private.id
  value = module.ascentt-vpc.private_subnet_id
}

# Public subnet CIDR
output "public_subnet_cidr" {
  description = "The public subnet CIDR in your VPC"
  #   value       = aws_subnet.public.cidr_block
  value = module.ascentt-vpc.public_subnet_cidr
}

# Public subnet CIDR
output "private_subnet_cidr" {
  description = "The private subnet CIDR in your VPC"
  #   value       = aws_subnet.private.cidr_block
  value = module.ascentt-vpc.public_subnet_cidr
}

# vpc Security group ID
output "Security_group_id" {
  description = "the Security group id in your custom vpc is :"
  #   value       = aws_security_group.mySG.id
  value = module.ascentt-vpc.Security_group_id
}



#####################################################################################################################################
#                                                       EC2 outputs
#***********************************************************************************************************************************

# Print Instance IP
output "instance_public_ip" {
  #   value       = aws_instance.test-pub-EC2.public_ip
  value       = module.ascentt-ec2.instance_public_ip
  description = "The public IP address of the main server instance."
}

output "instance_private_ip" {
  #   value       = aws_instance.test-priv-EC2.private_ip
  value       = module.ascentt-ec2.instance_private_ip
  description = "The public IP address of the main server instance."
}

# Print instance ID
output "public_instance_ID" {
  #   value = aws_instance.test-pub-EC2.id
  value = module.ascentt-ec2.public_instance_ID
}

output "private_instance_ID" {
  #   value = aws_instance.test-priv-EC2.id
  value = module.ascentt-ec2.private_instance_ID
}

