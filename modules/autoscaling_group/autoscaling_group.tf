resource "aws_autoscaling_group" "main_asg" {
  name                      = "${var.platform_name}-asg"
  count = local.worker_group_launch_template_count
  max_size = lookup(
  var.worker_groups_launch_template[count.index],
  "asg_max_size",
  local.workers_group_defaults["asg_max_size"],
  )

  vpc_zone_identifier = concat(var.private_subnets)
  min_size = lookup(
  var.worker_groups_launch_template[count.index],
  "asg_min_size",
  local.workers_group_defaults["asg_min_size"],
  )
  target_group_arns = [var.target_group_arns]
  desired_capacity = lookup(
  var.worker_groups_launch_template[count.index],
  "asg_desired_capacity",
  local.workers_group_defaults["asg_desired_capacity"],
  )

  force_delete = lookup(
  var.worker_groups_launch_template[count.index],
  "asg_force_delete",
  local.workers_group_defaults["asg_force_delete"],
  )
  placement_group = lookup(
  var.worker_groups_launch_template[count.index],
  "placement_group",
  local.workers_group_defaults["placement_group"],
  )

  termination_policies = lookup(
  var.worker_groups_launch_template[count.index],
  "termination_policies",
  local.workers_group_defaults["termination_policies"]
  )

  protect_from_scale_in = lookup(
  var.worker_groups_launch_template[count.index],
  "protect_from_scale_in",
  local.workers_group_defaults["protect_from_scale_in"],
  )

  #availability_zones = var.availability_zones_name

  launch_template {
    id = aws_launch_template.workers_launch_template.*.id[count.index]
    version = lookup(
    var.worker_groups_launch_template[count.index],
    "launch_template_version",
    local.workers_group_defaults["launch_template_version"],
    )
  }

  tags = concat([
    {
    key                 = "Owner"
    value               = "Oleksandr_Rudenko"
      propagate_at_launch = true
  }
  ])

  timeouts {
    delete = "15m"
  }
}




