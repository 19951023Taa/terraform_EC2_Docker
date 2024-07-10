variable "instance_type" {
  type    = string
  default = "m5.large"
}

variable "tags" {
  type    = map(any)
  default = {}
}

variable "is_eip" {
  type    = bool
  default = false
}

variable "subnet_id" {
  type    = string
  default = ""
}

variable "vpc_security_group_ids" {
  type    = list(any)
  default = []
}

variable "disable_api_termination" {
  type    = bool
  default = true
}

variable "private_ip" {
  type    = string
  default = ""
}

variable "key_name" {
  type    = string
  default = ""
}

variable "rbd_delete_on_termination" {
  type    = bool
  default = true
}

variable "rbd_volume_type" {
  type    = string
  default = "gp3"
}

variable "rbd_iops" {
  type    = string
  default = "3000"
}

variable "rbd_volume_size" {
  type    = string
  default = "200"
}

variable "rbd_encrypted" {
  type    = bool
  default = false
}

variable "rbd_kms_key_id" {
  type    = string
  default = ""
}

variable "ebd_delete_on_termination" {
  type    = bool
  default = true
}

variable "ebd_volume_type" {
  type    = string
  default = "gp3"
}

variable "ebd_iops" {
  type    = string
  default = "3000"
}

variable "ebd_volume_size" {
  type    = string
  default = "200"
}

variable "ebd_encrypted" {
  type    = bool
  default = false
}

variable "ebd_device_name" {
  type    = string
  default = ""
}

variable "ebd_kms_key_id" {
  type    = string
  default = ""
}

variable "name" {
  type    = string
  default = ""
}

variable "ami" {
  type    = string
  default = null
}

variable "eip_name" {
  type    = string
  default = ""
}

variable "eip_tags" {
  type    = map(any)
  default = {}
}

variable "role" {
  type    = string
  default = ""
}

variable "rbd_name" {
  type    = string
  default = ""
}

variable "rbd_tags" {
  type    = map(any)
  default = {}
}

variable "ebd_tags" {
  type    = map(any)
  default = {}
}

variable "root_block_device_name" {
  type    = string
  default = ""
}

variable "edb_block_device_name" {
  type    = string
  default = ""
}