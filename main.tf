provider "aws" {
  version = "2.33.0"

  region = var.aws_region
}

resource "aws_dynamodb_table" "dynamodb_table" {
  name = "staff"

  read_capacity  = var.db_read_capacity
  write_capacity = var.db_write_capacity
  hash_key       = "username"
  range_key      = "phone"

  attribute {
    name = "username"
    type = "S"
  }

  attribute {
    name = "phone"
    type = "S"
  }

  tags = {
    Name = "staff"
  }
}

resource "aws_security_group" "allow_ssh_web" {
  name        = "allow_ssh_web"
  description = "Allow ssh and web inbound traffic"
  vpc_id      = "vpc-0692223094247e401"

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "web"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_web"
  }
}

resource "aws_instance" "amazon_linux_2" {
  key_name      = "new-aws"
  ami           = "ami-01af223aa7f274198"
  instance_type = "t2.micro"
  subnet_id = var.default_subnet
  iam_instance_profile = "WebService"
  security_groups = [aws_security_group.allow_ssh_web.id]
  tags = {
    Name = "qytang ec2"
  }
  user_data = file("user_data.sh")
}