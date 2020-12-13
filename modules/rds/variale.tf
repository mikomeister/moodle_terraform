variable "db_username" {
  description = "The username for the DB master user"
  type        = string
}

variable "db_password" {
  description = "The password for the DB master user"
  type        = string
}
variable "port" {}
variable "db_identifier" {}
variable "instance_class" {}
variable "engine" {}
variable "engine_version" {}
variable "sg_id" {}
variable "vpc_id" {}
variable "db_to_create" {}

variable "cidr_blocks" {
  type = "map"

  default = {
    "sg_subnet" = "176.108.27.0/24"
    "all_ip"      = "0.0.0.0/0"
  }
}

variable "private_subnets" {}