output "endpoint" {
  value = "${join(":", list(aws_elasticache_cluster.cache.cache_nodes.0.address, aws_elasticache_cluster.cache.cache_nodes.0.port))}"
}