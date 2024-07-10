resource "aws_db_instance" "this" {
  engine         = var.engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  #  timezone                        = var.timezone
  apply_immediately    = var.apply_immediately
  storage_type         = var.storage_type
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  identifier           = var.identifier
  username             = var.username
  password             = var.password
  db_subnet_group_name = var.db_subnet_group_name
  #  option_group_name               = aws_db_option_group.this.name
  vpc_security_group_ids       = var.vpc_security_group_ids
  port                         = var.port
  parameter_group_name         = var.parameter_group_name
  storage_encrypted            = var.storage_encrypted
  backup_retention_period      = var.backup_retention_period
  backup_window                = var.backup_window
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  maintenance_window           = var.maintenance_window
  deletion_protection          = var.deletion_protection
  skip_final_snapshot          = var.skip_final_snapshot
  performance_insights_enabled = var.performance_insights_enabled
  monitoring_interval          = var.monitoring_interval
  monitoring_role_arn          = var.monitoring_role_arn
  ca_cert_identifier           = var.ca_cert_identifier

  tags = merge(
    { "Name" = var.identifier },
    var.tags
  )
}

resource "aws_db_subnet_group" "this" {
  name       = var.db_subnet_group_name
  subnet_ids = var.subnet_ids
}

resource "aws_db_parameter_group" "this" {
  name   = var.parameter_group_name
  family = var.family
}

# resource "aws_db_option_group" "this" {
#   name = var.option_group_name
#   engine_name = "PostgreSQL"
#   major_engine_version = "16"
# }
