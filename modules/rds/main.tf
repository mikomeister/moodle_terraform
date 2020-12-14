resource "aws_db_instance" "moodle" {
  name = var.db_to_create
  identifier = var.db_identifier
  instance_class = var.instance_class
  engine            = var.engine
  engine_version    = var.engine_version
  allocated_storage = 20
  max_allocated_storage = 1000
  username = var.db_username
  password = var.db_password
  port     = var.port
  publicly_accessible = true
  vpc_security_group_ids = [var.sg_id, aws_security_group.sg.id]
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
  deletion_protection = false
  maintenance_window = "fri:18:03-fri:18:33"
  backup_window      = "16:16-16:46"
  skip_final_snapshot = true
  copy_tags_to_snapshot = true

}

resource "aws_security_group" "sg" {
  name        = "all-connection-tcp-sg"
  description = "Main security group for network"
  vpc_id      = "${var.vpc_id}"

}
resource "aws_security_group_rule" "allow_all_egress" {
  type = "egress"

  to_port   = 0
  from_port = 0
  protocol  = "-1"

  security_group_id = "${aws_security_group.sg.id}"
  cidr_blocks       = ["${var.cidr_blocks["all_ip"]}"]
}
resource "aws_security_group_rule" "allow_http_ingress" {
  type      = "ingress"
  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"

  security_group_id = "${aws_security_group.sg.id}"
  cidr_blocks       = ["${var.cidr_blocks["sg_subnet"]}"] ////////0.0.0.0/0
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnets
}