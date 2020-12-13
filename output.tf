output "bastion_ip" {
  value = module.bastion.bastion_ip
}

output "efs_dns" {
  value = module.efs.dns_name
}

output "rds_username" {
  value = module.rds.db_username
}

output "rds_password" {
  value = module.rds.db_password
}

output "rds_endpoint" {
  value = module.rds.rds_endoint
}

output "rds_database" {
  value = module.rds.database_name
}

output "cache_endpoint" {
  value = module.redis_cache.endpoint
}