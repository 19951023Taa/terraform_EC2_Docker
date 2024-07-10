/* Common */
variable "ENV" {
  description = "PD/ST/DV/DR"
  type        = string
  default     = "st"
}

variable "subnet_cidrs" {}

variable "rds_password" {}