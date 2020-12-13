resource "aws_efs_file_system" "efs" {
  creation_token   = "${var.creation_token}"
  performance_mode = "${var.perfomance_mode}"
}

//resource "aws_efs_mount_target" "efs_mount" {
//  file_system_id  = "${aws_efs_file_system.efs.id}"
//  subnet_id       = "${var.subnet_ids[0]}"
//  security_groups = ["${var.security_groups}"]
//}

resource "aws_efs_mount_target" "efs_mount" {
  count = length(var.subnet_ids)
  file_system_id  = "${aws_efs_file_system.efs.id}"
  subnet_id       = "${element(var.subnet_ids, count.index)}"
  security_groups = ["${var.security_groups}"]
}
