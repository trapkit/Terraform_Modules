provider "aws" {
  region = var.aws_region
}


module "ascentt" {
  source = "./modules"
  vpc_id = module.ascentt.vpc_id
  # ec2_ami_id = "${var.ec2_ami_id}"
}
