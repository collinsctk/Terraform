provider "aws" {
  version = "2.33.0"

  region = var.aws_region
}

resource "aws_vpc" "qyt_aws_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "qyt_aws_vpc"
  }
}

resource "aws_subnet" "qyt_outside_subnet" {
  vpc_id = aws_vpc.qyt_aws_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "qyt_outside_subnet"
  }
}

resource "aws_internet_gateway" "qyt_internet_gw" {
  vpc_id = aws_vpc.qyt_aws_vpc.id

  tags = {
    Name = "qyt_internet_gw"
  }
}

resource "aws_route_table" "qyt_aws_route_table" {
  vpc_id = aws_vpc.qyt_aws_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.qyt_internet_gw.id
  }

  tags = {
    Name = "qyt_aws_route_table"
  }
}

resource "aws_route_table_association" "qyt_aws_route_table_association" {
  subnet_id      = aws_subnet.qyt_outside_subnet.id
  route_table_id = aws_route_table.qyt_aws_route_table.id
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

resource "aws_security_group" "qyt_aws_allow_ssh_web" {
  name        = "allow_ssh_web"
  description = "Allow ssh and web inbound traffic"
  vpc_id      = aws_vpc.qyt_aws_vpc.id

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
    Name = "qyt_aws_allow_ssh_web"
  }
}

resource "aws_instance" "amazon_linux_2" {
  key_name      = "new-aws"
  ami           = "ami-01af223aa7f274198"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.qyt_outside_subnet.id
  iam_instance_profile = "WebService"
  security_groups = [aws_security_group.qyt_aws_allow_ssh_web.id]
  tags = {
    Name = "qytang ec2"
  }
  user_data = file("user_data.sh")
}