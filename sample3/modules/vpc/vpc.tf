
# 1 Create VPC
resource "aws_vpc" "my-vpc" {
  cidr_block       = "${var.vpc_cidr_block}"
  instance_tenancy = "default"

  tags = {
    Name = "${var.vpc_name}"
  }
}


# Print VPC ID 
/* output "vpc_id" {
  value = aws_vpc.my-vpc.id
} */

# 2 Create Internet Gateway.
resource "aws_internet_gateway" "igw" {
  # vpc_id = aws_vpc.my-vpc.id
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "${var.IGW_name}"
  }
}

# 3 Subnet Creation

resource "aws_subnet" "public" {
  # vpc_id            = aws_vpc.my-vpc.id
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.public_subnet_cidr}"
  availability_zone       = var.availability_Zone_public
  # availability_zone       = var.availability_Zone.public
  map_public_ip_on_launch = true

  tags = {
    "Name" = "public-subnet"
  }
}
resource "aws_subnet" "private" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone       = var.availability_Zone_private
  # availability_zone       = var.availability_Zone.private
  map_public_ip_on_launch = false

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
  route_table_id = aws_route_table.private-RT.id
}



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
    Name = "${var.Security_group_name}"
  }
}
