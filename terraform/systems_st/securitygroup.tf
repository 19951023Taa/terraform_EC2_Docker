module "docker_sg" {
  source = "../modules/securitygroup"

  security_group_name        = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-docker-sg-01"
  security_group_description = "docker security group"
  vpc_id                     = module.vpc_main.vpc_id

  ingress_rules = [
    {
      from_port       = 80
      to_port         = 80
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      description     = "Allow HTTP inbound"
    },
    {
      from_port       = 8080
      to_port         = 8080
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      description     = "Allow HTTPS inbound"
    },
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    },
  ]
}


module "rds_sg" {
  source = "../modules/securitygroup"

  security_group_name        = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-postgresql-sg-01"
  security_group_description = "postgre security group"
  vpc_id                     = module.vpc_main.vpc_id

  ingress_rules = [
    {
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      cidr_blocks     = []
      security_groups = [module.docker_sg.security_group_id]
      description     = "Allow Docker sg"
    },
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    },
  ]
}