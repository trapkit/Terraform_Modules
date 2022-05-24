# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "4.8.0"
#     }
#   }
# }

####### Provider Configuration.
provider "aws" {
  region = "${var.aws_region}"
}

# 1 Create VPC
resource "aws_vpc" "my-vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "my-VPC"
  }
}

# Print VPC ID 
/* output "vpc_id" {
  value = vpc.my-vpc.id
} */

# 2 Create Internet Gateway.
resource "aws_internet_gateway" "igw" {
  # vpc_id = aws_vpc.my-vpc.id
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "my-IGW"
  }
}

# 3 Subnet Creation
/* resource "aws_subnet" "main" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.5.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Subnet-${count.index}"
  }
} */

data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_subnet" "public" {
  availability_zone = data.aws_availability_zones.available.names[0]
  # vpc_id            = aws_vpc.my-vpc.id
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.public_subnet_cidr}"

  tags = {
    "Name" = "public-subnet"
  }
}
resource "aws_subnet" "private" {
  availability_zone = data.aws_availability_zones.available.names[1]
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.private_subnet_cidr}"

  tags = {
    Name = "private-subnet"
  }
}
# 4 Route table creation
########## Public
resource "aws_route_table" "public-RT" {
  # vpc_id = aws_vpc.my-vpc.id
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public-RT"
  }
}
######## Associate route to public subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  # subnet_id      = "${var.public_subnet_id}"
  route_table_id = aws_route_table.public-RT.id
}

########### Private
resource "aws_route_table" "private-RT" {
  # vpc_id = aws_vpc.my-vpc.id
  vpc_id = "${var.vpc_id}"

  route = []

  tags = {
    Name = "Private-RT"
  }
}
######### Associate route to private subnet
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  # subnet_id = "${var.private_subnet_id}"
  route_table_id = aws_route_table.private-RT.id
}

#########################################################################################################
#               EC2 Instance 
##############################################################

# 1 Create a Security Group
resource "aws_security_group" "mySG" {
  name        = "my-SG"
  description = "Allow TLS inbound traffic"
  # vpc_id      = aws_vpc.my-vpc.id
  vpc_id = "${var.vpc_id}"

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "test_SG"
  }
}

# 2 CloudWatch Log Group
resource "aws_cloudwatch_log_group" "ec2Log" {
  name = "${var.CloudWatch_log_group_name}"

  tags = {
    Environment = "webServer"
    Application = "apache"
  }
}

# 3 Create instance
resource "aws_instance" "test-pub-EC2" {
  ami                         = "${var.ec2_ami_id}"
  instance_type               = "${var.ec2_instance_type}"
  subnet_id                   = aws_subnet.public.id
  # subnet_id = "${var.subnet_public_id}"
  key_name                    = "${var.pem_key}"
  tenancy                     = "default"
  vpc_security_group_ids = [aws_security_group.mySG.id]
  # vpc_security_group_ids = ["${var.Security_group_id}"]
  associate_public_ip_address = true
  user_data                   = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install -y apache2
                sudo systemctl start apache2
                cd /var/www/html/
                echo "<html><h1>Hey there , Let's test running and creating a module for the very first time !!</h1></html>" > index.html
                EOF

  tags = {
    Name = "test-Public-EC2"
  }
}

resource "aws_instance" "test-pr-EC2" {
  ami                         = "${var.ec2_ami_id}"
  instance_type               = "${var.ec2_instance_type}"
  subnet_id                   = aws_subnet.private.id
  # subnet_id = "${var.subnet_public_id}"
  key_name                    = "${var.pem_key}"
  tenancy                     = "default"
  vpc_security_group_ids = [aws_security_group.mySG.id]
  # vpc_security_group_ids = ["${var.Security_group_id}"]
  associate_public_ip_address = false
  user_data                   = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install -y apache2
                sudo systemctl start apache2
                cd /var/www/html/
                echo "<html><h1>Hey there , Let's test running and creating a module for the very first time !!</h1></html>" > index.html
                EOF

  tags = {
    Name = "test-Private-EC2"
  }
}