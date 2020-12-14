variable "region" {
  description = "The AWS region to deploy the cluster into (e.g. eu-central-1)"
  type        = "string"
  default     = "eu-central-1"
}

variable "aws_profile" {
  description = "AWS profile that used for deployment"
  type        = "string"
}

variable "platform_name" {
  description = "The name of the cluster that is used for tagging resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC id in which we deploy EKS cluster"
  type        = string
}

variable "private_subnets_id" {
  description = "A list of subnets to place the EKS cluster and workers within"
  type        = list
}

variable "public_subnets_id" {
  description = "A list of subnets to place the LB and other external resources"
  type        = list
}

variable "platform_cidr" {
  description = "CIRD of your future or existing VPC"
  type        = "string"
}

variable "private_cidrs" {
  description = "CIRD of your future or existing VPC"
  type        = "list"
  default     = []
}

variable "public_cidrs" {
  description = "CIRD of your future or existing VPC"
  type        = "list"
  default     = []
}

variable "instance_types" {
  description = "Type of EC2 instances that will used in ASG"
  type        = "list"
  default     = ["t2.micro"]
}

variable "max_nodes_count" {
  description = "Max nodes count in ASG"
  default     = 2
}

variable "desired_nodes_count" {
  description = "Desired nodes count in ASG"
  default     = 3
}

variable "demand_nodes_count" {
  description = "On-demand nodes count in ASG" // Must be less or equal to desired_nodes_count
  default     = 3
}


variable "key_name" {
  description = "The name of AWS ssh key to create and attach to all created nodes"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map
}

variable "create_external_zone" {
  description = "Boolean variable which defines weather external zone will be created or existing will be used"
  type        = bool
  default     = false
}

variable "ami_id" {
  description = "The AWS ami id for Infrastructure deployment"
  type        = "string"
}

variable "platform_external_subdomain" {
  description = "The name of existing or to be created(depends on create_external_zone variable) external DNS zone"
  type        = string
  default     = ""
}

variable "certificate_arn" {
  description = "The ARN of the existing SSL certificate"
  type        = string
  default     = ""
}

variable "availability_zone_names" {
  type    = list(string)
}

variable "db_username" {
  description = "The username for the DB master user"
  type        = string
}
variable "db_password" {
  description = "The password for the DB master user"
  type        = string
}

variable "hosted_zone_id" {
  description = "Hosted zone id to create records there"
  type = string
}

variable "moodle_subdomain" {
  description = "name of the DNS subdomain "
}

variable "full_moodle_domain" {}