provider "aws" {
  version = "~> 3.0"

  region = var.aws_region
}

resource "aws_vpc" "qyt_aws_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "qyt_aws_vpc"
  }
}
