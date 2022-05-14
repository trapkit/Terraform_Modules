variable "ec2_ami_id" {
  type        = any
  description = "Provide an AMI ID either an ubuntu ami or amazon-ec2 ami to use for instance creation"
}

variable "ec2_instance_type" {
  type        = any
  description = "Provide an instance type/family to use"
}

variable "instance_key_pair" {
  type        = string
  description = "Provide a KEY PAIR to attach to your instance"
}

variable "instance_name" {
  type        = any
  description = "Provide a TAG NAME to your instance."
}

variable "CloudWatch_log_group_name" {
  default = "ec2Logs"
}

variable "Security_group_id" {}

variable "public_subnet_id" {}

variable "private_subnet_id" {}