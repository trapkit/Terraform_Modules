#  - example

# image_id = "ami-abc123"
# availability_zone_names = [
#   "us-east-1a",
#   "us-west-1c",
# ]

ec2_ami_id        = "ami-09d56f8956ab235b3"
ec2_instance_type = "t2.micro"
instance_key_pair = "virginia-livux-key"

vpc_cidr_block            = "10.12.0.0/16"
vpc_name                  = "my_test_vpc_module"
IGW_name                  = "module-IGW"
public_subnet_cidr        = "10.12.2.0/24"
private_subnet_cidr       = "10.12.3.0/24"
availability_Zone_public  = "us-east-1a"
availability_Zone_private = "us-east-1c"