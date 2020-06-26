output "vpc_id" {
  value = aws_vpc.qyt_aws_vpc.id
}

output "vpc_arn" {
  value = aws_vpc.qyt_aws_vpc.arn
}

output "vpc_cidr" {
  value = aws_vpc.qyt_aws_vpc.cidr_block
}