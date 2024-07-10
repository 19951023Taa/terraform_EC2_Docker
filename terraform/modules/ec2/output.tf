output "instance_arn" {
  value = aws_instance.this.arn
}

output "instance_id" {
  value = aws_instance.this.id
}

output "tags" {
  value = aws_instance.this.tags_all
}