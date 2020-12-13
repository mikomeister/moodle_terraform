resource "aws_elasticache_cluster" "cache" {
  cluster_id           = "moodle-cluster"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.subnet_group.name
}

resource "aws_elasticache_subnet_group" "subnet_group" {
  name       = "tf-test-cache-subnet"
  subnet_ids = var.private_subnets
}