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

