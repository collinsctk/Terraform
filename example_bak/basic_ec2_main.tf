provider "aws" {
  version = "2.33.0"

  region = var.aws_region
}


resource "aws_instance" "amazon_linux_2" {
  key_name      = "new-aws"
  ami           = "ami-01af223aa7f274198"
  instance_type = "t2.micro"
  subnet_id = var.default_subnet
  tags = {
    Name = "qytang ec2"
  }
}