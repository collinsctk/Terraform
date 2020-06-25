provider "aws" {
  version = "2.33.0"

  region = var.aws_region
}


resource "aws_instance" "amazon_linux_2" {
  key_name      = "new-aws"
  ami           = "ami-01af223aa7f274198"
  instance_type = "t2.micro"

  tags = {
    Name = "qytang ec2"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_ssh"
  description = "Allow SSH"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
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
    Name = "allow_all"
  }
}
