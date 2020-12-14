resource "aws_elasticache_cluster" "cache" {
  cluster_id           = "moodle-cluster"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.subnet_group.name
  security_group_ids = [aws_security_group.sg.id]
}

resource "aws_elasticache_subnet_group" "subnet_group" {
  name       = "tf-test-cache-subnet"
  subnet_ids = var.private_subnets
}

resource "aws_security_group" "sg" {
  name        = "cache-sg"
  description = "Main security group for cache"
  vpc_id      = "${var.vpc_id}"

}

resource "aws_security_group_rule" "allow_http_ingress" {
  type      = "ingress"
  from_port = 6379
  to_port   = 6379
  protocol  = "tcp"

  security_group_id = "${aws_security_group.sg.id}"
  cidr_blocks       = ["${var.cidr_blocks["sg_subnet"]}"]
}