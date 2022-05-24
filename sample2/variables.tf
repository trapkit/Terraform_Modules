
variable "aws_region" {
  type        = string
  description = "The aws region where you want to launch your instances."
  default     = "us-east-1"
}

# variable "Security_group_id" {}

################################################################################################################################################
#******                                   VPC module variables
#***********************************************************************************************************************************************

variable "vpc_cidr_block" {
  type        = string
  description = "Provide a VPC CIDR block ."
}

variable "vpc_name" {
  type        = string
  description = "Provide a TAG-NAME for your vpc to specify"
}

variable "IGW_name" {
  type        = string
  description = "Provide a NAME for internet gateway to be attached to vpc"
}

variable "public_subnet_cidr" {
  description = "Provide a PUBLIC SUBNET CIDR range inside the VPC"
  type        = string
}

variable "private_subnet_cidr" {
  description = "Provide a PRIVATE SUBNET CIDR range inside the VPC"
  type        = string
}

variable "availability_Zone_public" {
  # type        = list(string)
  type = string
  # type = list(string)
  description = "Provide the PUBLIC availability zone in the form of a list for each subnet in your vpc"
}


variable "availability_Zone_private" {
  # type        = list(string)
  type = string
  # type = list(string)
  description = "Provide the PRIVATE availability zone in the form of a list for each subnet in your vpc"
}


################################################################################################################################################
#******                                   EC2 module variables
#***********************************************************************************************************************************************


variable "ec2_ami_id" {
  type        = string
  description = "Provide an AMI ID either an ubuntu ami or amazon-ec2 ami to use for instance creation"
}

variable "ec2_instance_type" {
  type        = string
  description = "Provide an instance type/family to use"
}

variable "instance_key_pair" {
  type        = string
  description = "Provide a KEY PAIR to attach to your instance"
}

