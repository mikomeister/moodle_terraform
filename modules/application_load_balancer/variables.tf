variable "create_external_zone" {
  description = "Boolean variable which defines weather external zone will be created or existing will be used"
  type        = bool
  default     = false
}
variable "certificate_arn" {}
variable "platform_name" {}
variable "subnets" {}
variable "sg_id" {}
variable "vpc_id" {}