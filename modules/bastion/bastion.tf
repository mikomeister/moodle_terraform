resource "aws_instance" "bastion" {
  ami                         = "${var.ami_id}"
  instance_type               = "t2.micro"
  subnet_id                   = "${var.public_subnet_id}"
  associate_public_ip_address = true
  key_name                    = "${var.key_name}"
  vpc_security_group_ids = [aws_security_group.bastion.id]

}

resource "aws_eip" "bastion" {
  tags = map("Name", var.platform_name)
}

resource "aws_eip_association" "eip_bastion" {
  instance_id   = "${aws_instance.bastion.id}"
  allocation_id = "${aws_eip.bastion.id}"
}

resource "aws_security_group" "bastion" {
  name        = "${var.platform_name}-bastion"
  description = "Bastion group for ${var.platform_name}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${var.vpc_id}"

}