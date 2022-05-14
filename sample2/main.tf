provider "aws" {
  region = var.aws_region
}


module "ascentt-vpc" {
  source = "./modules/vpc"
  vpc_id = module.ascentt-vpc.vpc_id
  # ec2_ami_id = "${var.ec2_ami_id}"
  vpc_cidr_block            = var.vpc_cidr_block
  vpc_name                  = var.vpc_name
  IGW_name                  = var.IGW_name
  Security_group_name       = "terra-module-SG"
  public_subnet_cidr        = var.public_subnet_cidr
  private_subnet_cidr       = var.private_subnet_cidr
  availability_Zone_public  = var.availability_Zone_public
  availability_Zone_private = var.availability_Zone_private
  # Security_group_id = module.ascentt-vpc.Security_group_id
}

module "ascentt-ec2" {
  source            = "./modules/ec2"
  ec2_ami_id        = var.ec2_ami_id
  ec2_instance_type = var.ec2_instance_type
  instance_key_pair = var.instance_key_pair
  instance_name     = "terra_instance"
  Security_group_id = module.ascentt-vpc.Security_group_id
  public_subnet_id  = module.ascentt-vpc.public_subnet_id
  private_subnet_id = module.ascentt-vpc.private_subnet_id
}