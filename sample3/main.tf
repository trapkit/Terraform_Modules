provider "aws" {
  region = var.aws_region
}


module "ascentt-vpc" {
  source = "./modules/vpc"
  vpc_id = module.ascentt-vpc.vpc_id
  # ec2_ami_id = "${var.ec2_ami_id}"
  vpc_cidr_block            = "10.7.0.0/16"
  vpc_name                  = "terra-module-vpc"
  IGW_name                  = "terra-IGW"
  Security_group_name       = "terra-module-SG"
  public_subnet_cidr        = "10.7.2.0/24"
  private_subnet_cidr       = "10.7.5.0/24"
  availability_Zone_public  = var.availability_Zone_public
  availability_Zone_private = var.availability_Zone_private
  # Security_group_id = module.ascentt-vpc.Security_group_id
}

module "ascentt-ec2" {
  source            = "./modules/ec2"
  ec2_ami_id        = "ami-09d56f8956ab235b3"
  ec2_instance_type = "t2.medium"
  instance_key_pair = "virginia-livux-key"
  instance_name     = "terra_instance"
  Security_group_id = module.ascentt-vpc.Security_group_id
  public_subnet_id  = module.ascentt-vpc.public_subnet_id
  private_subnet_id = module.ascentt-vpc.private_subnet_id
}