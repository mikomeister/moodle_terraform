module "vpc" {
  source = "./modules/vpc/"

  platform_name = "${lower(var.platform_name)}"

  vpc_id             = "${var.vpc_id}"
  platform_cidr      = "${var.platform_cidr}"
  private_cidrs      = "${var.private_cidrs}"
  public_cidrs       = "${var.public_cidrs}"
  public_subnet_ids  = "${var.public_subnets_id}"
  private_subnet_ids = "${var.private_subnets_id}"
  tags               = "${var.tags}"
}

module "application_load_balancer" {
  source          = "./modules/application_load_balancer/"

  certificate_arn = var.certificate_arn
  platform_name   = var.platform_name
  subnets         = module.vpc.public_subnet_ids
  sg_id           = [module.security_group.sg_id]
  vpc_id          = module.vpc.vpc_id

}

module "rds" {
  source = "./modules/rds/"

  db_password = var.db_password
  db_username = var.db_username
  db_identifier = "moodle"
  instance_class = "db.t2.micro"
  engine = "postgres"
  engine_version = "12.4"
  port = "5432"
  sg_id = module.security_group.sg_id
  vpc_id = module.vpc.vpc_id
  db_to_create = "moodle"
  private_subnets = module.vpc.private_subnet_ids

}

module "redis_cache" {
  source = "./modules/redis_cache/"

  cluster_id = "moodle"
  cache_node_count = 1
  node_type = "cache.t2.micro"
  private_subnets = module.vpc.private_subnet_ids
  vpc_id = module.vpc.vpc_id
}

module "autoscaling_group" {
  source                  = "./modules/autoscaling_group/"
  database_name           = module.rds.database_name
  rds_endpoint            = module.rds.rds_endoint
  cache_endpoint          = module.redis_cache.endpoint
  domain_name             = var.full_moodle_domain
  private_subnets         = module.vpc.private_subnet_ids
  public_subnets          = module.vpc.public_subnet_ids
  workers_security_groups = module.security_group.sg_id
  platform_name           = var.platform_name
  availability_zones_name = var.availability_zone_names
  efs_dns                 = module.efs.dns_name
  instance_profile_name   = "MoodleInstanceProfileRole"
  target_group_arns       = module.application_load_balancer.target_group_arn
  worker_groups_launch_template = [
    {
      name                    = "${var.platform_name}-worker"
      override_instance_types = var.instance_types
      spot_instance_pools     = 0
      asg_min_size            = 1
      asg_max_size            = var.max_nodes_count
      asg_desired_capacity    = var.desired_nodes_count
      on_demand_base_capacity = var.demand_nodes_count
      suspended_processes     = ["AZRebalance", "ReplaceUnhealthy", "Terminate"]
      public_ip               = false
      root_volume_size          = 50
      enable_monitoring         = false
      key_name                  = var.key_name
      ami_id                    = var.ami_id
      instance_type = var.instance_types[0]
    }
  ]
  tags = "${var.tags}"
}

module "security_group" {
  source        = "./modules/security_group/"

  efs_port      = "2049"
  platform_name = var.platform_name
  vpc_id = module.vpc.vpc_id
}

module "efs" {
  source          = "./modules/efs/"

  creation_token  = "${var.platform_name}-efs"
  perfomance_mode = "generalPurpose"
  security_groups = "${module.security_group.sg_id}"
  subnet_ids      = "${module.vpc.private_subnet_ids}"
}


module "bastion" {
  source = "./modules/bastion/"

  ami_id        = "ami-dd3c0f36"
  vpc_id             = module.vpc.vpc_id
  key_name           = var.key_name
  platform_name      = var.platform_name
  public_subnet_id   = module.vpc.public_subnet_ids[0]
}

resource "aws_route53_record" "alb_record" {
  name = var.moodle_subdomain
  type = "CNAME"
  zone_id = var.hosted_zone_id
  ttl     = "300"
  records = [module.application_load_balancer.dns]
}