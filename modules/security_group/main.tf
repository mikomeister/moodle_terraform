resource "aws_security_group" "sg" {
  name        = "${var.platform_name}-sg"
  description = "Main security group for network"
  vpc_id      = "${var.vpc_id}"

}

resource "aws_security_group_rule" "allow_http_ingress" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  security_group_id = "${aws_security_group.sg.id}"
  cidr_blocks       = ["${var.cidr_blocks["sg_subnet"]}"]
}


resource "aws_security_group_rule" "allow_ssh_ingress" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"

  security_group_id = "${aws_security_group.sg.id}"
  cidr_blocks       = ["${var.cidr_blocks["sg_subnet"]}"]
}

resource "aws_security_group_rule" "allow_all_egress" {
  type = "egress"

  to_port   = 0
  from_port = 0
  protocol  = "-1"

  security_group_id = "${aws_security_group.sg.id}"
  cidr_blocks       = ["${var.cidr_blocks["all_ip"]}"]
}

resource "aws_security_group_rule" "efs_rules" {
  from_port         = "${var.efs_port}"
  protocol          = "tcp"
  security_group_id = "${aws_security_group.sg.id}"
  to_port           = "${var.efs_port}"
  type              = "ingress"
  cidr_blocks       = ["${var.cidr_blocks["sg_subnet"]}"]
}
