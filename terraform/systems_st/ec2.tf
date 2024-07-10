module "ec2_Docker" {
  source = "../modules/ec2/"

  name          = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-ec2-01"
  instance_type = "t3.micro"
  ami           = "ami-03350e4f182961c7f"

  subnet_id  = module.vpc_subnets["public_subnet_c_01"].subnet_id
  private_ip = "10.0.2.10"
  key_name   = "terraform-test"
  eip_name   = "ec2_Docker_ip"
  role       = "ssm_role"
  vpc_security_group_ids = [
    module.docker_sg.security_group_id
  ]

  disable_api_termination = true

  rbd_name                  = "/dev/sda1"
  root_block_device_name    = "${local.PROJECT}-${local.SYSTEM}-${var.ENV}-ec2-01-rootdevice"
  rbd_delete_on_termination = true
  rbd_volume_type           = "gp3"
  rbd_iops                  = 3000
  rbd_volume_size           = 10
  rbd_encrypted             = false
}

resource "aws_iam_role" "ssm_role" {
  name = "ssm_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}