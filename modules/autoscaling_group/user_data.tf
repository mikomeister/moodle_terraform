data "template_file" "user_data" {
  template = "${file("./modules/autoscaling_group/templates/user_data.tpl")}"

  vars = {
    efs_address           = "${var.efs_dns}"
    rds_endpoint = replace(var.rds_endpoint, ":5432", "")
    cache_endpoint = replace(var.cache_endpoint, ":6379","")
    domain_name = var.domain_name
    database_name = var.database_name
  }
}
