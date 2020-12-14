variable "platform_name" {}
variable "efs_port" {}

variable "tag_contact" {
  default = "oleksandr_rudenko2@epam.com"
}

variable "vpc_id" {}

variable "cidr_blocks" {
  type = "map"

  default = {
    "sg_subnet" = "10.72.0.0/16"
    "all_ip"    = "0.0.0.0/0"
    "home_cidr" = "85.223.209.0/24"
  }
}
