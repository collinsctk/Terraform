output "instance_ip_addr" {
  value = aws_instance.amazon_linux_2.private_ip
}

output "instance_public_ip_addr" {
  value = aws_instance.amazon_linux_2.public_ip
}

output "instance_public_sg" {
  value = aws_instance.amazon_linux_2.security_groups
}