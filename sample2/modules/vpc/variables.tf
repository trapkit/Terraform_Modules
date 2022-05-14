
variable "vpc_id" {}     #  this will be known from output after terraform apply

variable "vpc_cidr_block" {
  type        = string
  description = "Provide a VPC CIDR block ."
}

variable "vpc_name" {
  type        = string
  description = "Provide a TAG-NAME for your vpc to specify"
}

variable "IGW_name" {
  type        = any
  description = "Provide a NAME for internet gateway to be attached to vpc"
}



variable "availability_Zone_public" {
  # type        = list(string)
  type = string
  # default = "us-east-1a"
  # type = list(string)
  description = "Provide the PUBLIC availability zone in the form of a list for each subnet in your vpc"
}


variable "availability_Zone_private" {
  # type        = list(string)
  type = string
  # default = "us-east-1b" 
  # type = list(string)
  description = "Provide the PRIVATE availability zone in the form of a list for each subnet in your vpc"
}

#variable "availability_Zone_private" {}

variable "Security_group_name" {
  type        = string
  description = "Provide a name for your SECURITY GROUP in your main vpc"

}


variable "public_subnet_cidr" {
  description = "Provide a PUBLIC SUBNET CIDR range inside the VPC"
  type        = string
}

variable "private_subnet_cidr" {
  description = "Provide a PRIVATE SUBNET CIDR range inside the VPC"
  type        = string
}

# variable "Security_group_id" {}