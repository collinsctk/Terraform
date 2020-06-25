output "id" {
  description = "List of IDs of instances"
  value       = aws_instance.this.*.id
}