
variable "tags" {
  type        = any
  description = "A map of tags to add to all resources."
}
variable "worker_groups_launch_template" {
  description = "A list of maps defining worker group configurations to be defined using AWS Launch Templates. See workers_group_defaults for valid keys."
  type        = any
  default     = []
}

variable "platform_name" {
  description = "The name of the cluster that is used for tagging resources"
  type        = string
}

variable "worker_additional_security_group_ids" {
  description = "A list of additional security group ids to attach to worker instances"
  type        = list(string)
  default     = []
}

variable "worker_groups" {
  description = "A list of maps defining worker group configurations to be defined using AWS Launch Configurations. See workers_group_defaults for valid keys."
  type        = any
  default     = []
}

variable "public_subnets" {
  description = "A list of subnets to place the EKS cluster and workers within."
}

variable "private_subnets" {
  description = "A list of private subnets to place the EKS cluster and workers within."
}


variable "workers_group_defaults" {
  description = "Override default values for target groups. See workers_group_defaults_defaults in local.tf for valid keys."
  type        = any
  default     = {}
}
variable "workers_security_groups" {}

variable "availability_zones_name" {
  type    = list(string)
}
variable "efs_dns" {}
variable "instance_profile_name" {}
variable "target_group_arns" {}
variable "rds_endpoint" {}
variable "cache_endpoint" {}
variable "domain_name" {}
variable "database_name" {}