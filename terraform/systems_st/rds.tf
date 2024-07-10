module "rds_main" {
  source = "../modules/rds"

  engine                 = "postgres"
  engine_version         = "16.3"
  instance_class         = "db.t3.medium"
  storage_type           = "gp3"
  allocated_storage      = 20
  db_name                = "testdb"
  identifier             = "${lower("${local.PROJECT}")}-${lower("${local.SYSTEM}")}-${lower("${var.ENV}")}-rds-postgres-01"
  username               = "postgres"
  password               = var.rds_password
  db_subnet_group_name   = "${lower("${local.PROJECT}")}-${lower("${local.SYSTEM}")}-${lower("${var.ENV}")}-db-subnetgroup-01"
  vpc_security_group_ids = [module.rds_sg.security_group_id]
  port                   = 5432
  parameter_group_name   = "${lower("${local.PROJECT}")}-${lower("${local.SYSTEM}")}-${lower("${var.ENV}")}-db-parametergroup-01"
  storage_encrypted       = true
  backup_retention_period = 0
  monitoring_interval     = 60
  monitoring_role_arn     = aws_iam_role.rds_monitoring_role.arn
  ca_cert_identifier      = "rds-ca-rsa2048-g1"


  auto_minor_version_upgrade   = false
  maintenance_window           = "Fri:16:00-Fri:16:30" #UTC時間 日本時間1:00～1:30
  deletion_protection          = false
  performance_insights_enabled = true

  subnet_ids = [
    module.vpc_subnets["private_subnet_a_01"].subnet_id,
    module.vpc_subnets["private_subnet_c_01"].subnet_id
  ]

  family = "postgres16"
}


resource "aws_iam_role" "rds_monitoring_role" {
  name = "rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_role_policy" {
  role       = aws_iam_role.rds_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}