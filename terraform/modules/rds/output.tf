output "rds_id" {
  value = aws_db_instance.this.id
}

output "rds_arn" {
  value = aws_db_instance.this.arn
}

output "instance_id" {
  value = aws_db_instance.this.resource_id
}