
# VPC region
variable "aws_region" {
  default     = "us-east-1"
  type        = string
  description = "Define an AWS region to create your VPC into."
}

# VPC CIDR Range
variable "vpc_cidr" {
  default = "10.5.0.0/16"
  type    = any
}
# VPC ID 
variable "vpc_id" {}

variable "public_subnet_cidr" {
  description = "A list of public subnets inside the VPC"
  type        = any
  default     = "10.5.2.0/24"
}

variable "private_subnet_cidr" {
  description = "A list of private subnets inside the VPC"
  type        = any
  default     = "10.5.3.0/24"
}

# Subnet ID
/* variable "aws_subnet" {
  count = 2
} */
# variable "private_subnet_id" {}

# Security Group ID
# variable "Security_group_id" {}

/* variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
} */

/* variable "create_igw" {
  description = "Controls if an Internet Gateway is created for public subnets and the related routes that connect them."
  type        = bool
  default     = true
} */

variable "ec2_ami_id" {
  default     = "ami-04505e74c0741db8d"
  type        = any
  description = "The ami id to use for instance creation"
}

variable "ec2_instance_type" {
  default     = "t2.medium"
  description = "The instance type/family to use"
}

variable "pem_key" {
  default = "virginia-livux-key"
}

variable "CloudWatch_log_group_name" {
  default = "ec2Logs"
}