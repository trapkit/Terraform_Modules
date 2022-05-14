
variable "aws_region" {
  type        = string
  description = "The aws region where you want to launch your instances."
  default     = "us-east-1"
}

# variable "Security_group_id" {}


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

