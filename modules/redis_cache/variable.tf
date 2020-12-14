variable "cluster_id" {
  default = "redis"
}
variable "node_type" {
  default = "cache.t2.micro"
}
variable "cache_node_count" {
  default = 1
}

variable "private_subnets" {}

variable "cidr_blocks" {
  type = "map"

  default = {
    "sg_subnet" = "10.0.0.0/8"
    "all_ip"      = "0.0.0.0/0"
  }
}

variable "vpc_id" {}