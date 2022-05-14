
####  CloudWatch Log Group
resource "aws_cloudwatch_log_group" "ec2Log" {
  name = "${var.CloudWatch_log_group_name}"

  tags = {
    Environment = "webServer"
    Application = "apache"
  }
}

# Create instance
resource "aws_instance" "test-pub-EC2" {
  ami                         = "${var.ec2_ami_id}"
  instance_type               = "${var.ec2_instance_type}"
  # subnet_id                 = aws_subnet.public.id
  subnet_id                   = "${var.public_subnet_id}"
  key_name                    = "${var.instance_key_pair}"
  tenancy                     = "default"
  # vpc_security_group_ids    = [aws_security_group.mySG.id]
  vpc_security_group_ids      = [var.Security_group_id]
  # vpc_security_group_ids    = ["${var.Security_group_id}"]
  user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install -y apache2
                sudo systemctl start apache2
                cd /var/www/html/
                echo "<html><h1>Hey there ,Congrajulations you have succesfully created an instance and a vpc using a reusable module in terraform !!!</h1></html>" > index.html
                EOF

  tags = {
    Name = "${var.instance_name}-Public"
  }
}

resource "aws_instance" "test-priv-EC2" {
  ami                         = var.ec2_ami_id
  instance_type               = var.ec2_instance_type
  # subnet_id                 = aws_subnet.private.id
  subnet_id                   = "${var.private_subnet_id}"
  key_name                    = var.instance_key_pair
  tenancy                     = "default"
  vpc_security_group_ids      = [var.Security_group_id]
  # vpc_security_group_ids    = ["${var.Security_group_id}"]
  user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update
                sudo apt-get install -y apache2
                sudo systemctl start apache2
                cd /var/www/html/
                echo "<html><h1>Hey there , this is a private instance created usind a module for the very first time !!</h1></html>" > index.html
                EOF

  tags = {
    Name = "${var.instance_name}-Private"
  }
}