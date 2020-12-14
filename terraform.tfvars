region        = "eu-central-1"
aws_profile   = "own"
platform_name = "main"

create_external_zone = false
demand_nodes_count   = 1
max_nodes_count      = 1
desired_nodes_count = 1
vpc_id               = ""
platform_cidr        = "10.72.0.0/16"

ami_id = "ami-0649a2ac1437cf3b7"

platform_external_subdomain = "rudenko.link"
certificate_arn  = "arn:aws:acm:eu-central-1:508800916858:certificate/00ad5893-22de-4fad-b6c2-96729960d701"
key_name = "moodle"
private_subnets_id = []
private_cidrs      = ["10.72.0.0/22", "10.72.4.0/22", "10.72.8.0/22"]
availability_zone_names = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
public_subnets_id = []
public_cidrs      = ["10.72.12.0/22", "10.72.16.0/22", "10.72.20.0/22"]
hosted_zone_id = "Z09748211SFPPXO2A2K4"
moodle_subdomain = "moodle"
instance_types = ["t3.medium"]
full_moodle_domain = "moodle.rudenko.link"

tags = {
  "Owner" = "Oleksandr_Rudenko"
}