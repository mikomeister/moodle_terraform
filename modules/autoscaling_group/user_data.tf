data "template_file" "user_data" {
  template = "${file("./modules/autoscaling_group/templates/user_data.tpl")}"

  vars = {
    efs_address           = "${var.efs_dns}"
  }
}
