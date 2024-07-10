locals {
  is_eip  = length(var.eip_name) > 0 ? 1 : 0
  is_role = length(var.role) > 0 ? 1 : 0
  is_ebd  = length(var.ebd_device_name) > 0 ? 1 : 0
  ebd = {
    1 = {
      delete_on_termination = var.ebd_delete_on_termination
      volume_type           = var.ebd_volume_type
      iops                  = var.ebd_iops
      volume_size           = var.ebd_volume_size
      encrypted             = var.ebd_encrypted
      kms_key_id            = var.ebd_kms_key_id
      device_name           = var.ebd_device_name
      edb_block_device_name = var.edb_block_device_name
    }
  }
}

resource "aws_eip" "this" {
  count    = local.is_eip
  instance = aws_instance.this.id
  tags = merge(
    { "Name" = var.eip_name },
    var.eip_tags,
  )
}

resource "aws_iam_instance_profile" "this" {
  count = local.is_role
  name  = var.role
  role  = var.role
}

resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = merge(
    { "Name" = var.name },
    var.tags,
  )

  private_ip              = var.private_ip
  subnet_id               = var.subnet_id
  key_name                = var.key_name
  vpc_security_group_ids  = var.vpc_security_group_ids
  disable_api_termination = var.disable_api_termination
  iam_instance_profile    = var.role

  root_block_device {
    delete_on_termination = var.rbd_delete_on_termination
    volume_type           = var.rbd_volume_type
    iops                  = var.rbd_iops
    volume_size           = var.rbd_volume_size
    encrypted             = var.rbd_encrypted
    kms_key_id            = var.rbd_kms_key_id
    tags = merge(
      { "Name" = var.root_block_device_name },
      var.rbd_tags,
    )
  }

  #   dynamic "ebs_block_device" {
  #     for_each = length(var.ebd_device_name) > 0 ? local.ebd : {}
  #     content {
  #       delete_on_termination = var.ebd_delete_on_termination
  #       volume_type           = var.ebd_volume_type
  #       iops                  = var.ebd_iops
  #       volume_size           = var.ebd_volume_size
  #       encrypted             = var.ebd_encrypted
  #       kms_key_id            = var.ebd_kms_key_id
  #       device_name           = var.ebd_device_name
  #       tags = merge(
  #         { "Name" = var.edb_block_device_name },
  #         var.ebd_tags,
  #      )    
  #     }
  #   }
}
