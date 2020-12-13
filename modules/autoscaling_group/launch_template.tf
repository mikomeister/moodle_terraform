resource "aws_launch_template" "workers_launch_template" {
  count = local.worker_group_launch_template_count
  name_prefix = "${var.platform_name}-${lookup(
    var.worker_groups_launch_template[count.index],
    "name",
    count.index,
  )}"

  user_data = base64encode(data.template_file.user_data.rendered)

  network_interfaces {
    associate_public_ip_address = lookup(
    var.worker_groups_launch_template[count.index],
    "public_ip",
    local.workers_group_defaults["public_ip"],
    )

    delete_on_termination = lookup(
    var.worker_groups_launch_template[count.index],
    "eni_delete",
    local.workers_group_defaults["eni_delete"],
    )

    security_groups = [var.workers_security_groups]
  }


  image_id = lookup(
  var.worker_groups_launch_template[count.index],
  "ami_id",
  local.workers_group_defaults["ami_id"],
  )
  instance_type = lookup(
  var.worker_groups_launch_template[count.index],
  "instance_type",
  local.workers_group_defaults["instance_type"],
  )
  key_name = lookup(
  var.worker_groups_launch_template[count.index],
  "key_name",
  local.workers_group_defaults["key_name"],
  )

  ebs_optimized = lookup(
  var.worker_groups_launch_template[count.index],
  "ebs_optimized",
  lookup(
  local.ebs_optimized,
  lookup(
  var.worker_groups_launch_template[count.index],
  "instance_type",
  local.workers_group_defaults["instance_type"],
  ),
  false,
  ),
  )

  credit_specification {
    cpu_credits = lookup(
    var.worker_groups_launch_template[count.index],
    "cpu_credits",
    local.workers_group_defaults["cpu_credits"]
    )
  }

  monitoring {
    enabled = lookup(
    var.worker_groups_launch_template[count.index],
    "enable_monitoring",
    local.workers_group_defaults["enable_monitoring"],
    )
  }

  placement {
    tenancy = lookup(
    var.worker_groups_launch_template[count.index],
    "launch_template_placement_tenancy",
    local.workers_group_defaults["launch_template_placement_tenancy"],
    )
    group_name = lookup(
    var.worker_groups_launch_template[count.index],
    "launch_template_placement_group",
    local.workers_group_defaults["launch_template_placement_group"],
    )
  }

  iam_instance_profile {
    name = var.instance_profile_name
  }

  dynamic instance_market_options {
    for_each = lookup(var.worker_groups_launch_template[count.index], "market_type", null) == null ? [] : list(lookup(var.worker_groups_launch_template[count.index], "market_type", null))
    content {
      market_type = instance_market_options.value
    }
  }

  block_device_mappings {
    device_name = lookup(
    var.worker_groups_launch_template[count.index],
    "root_block_device_name",
    local.workers_group_defaults["root_block_device_name"],
    )

    ebs {
      volume_size = lookup(
      var.worker_groups_launch_template[count.index],
      "root_volume_size",
      local.workers_group_defaults["root_volume_size"],
      )
      volume_type = lookup(
      var.worker_groups_launch_template[count.index],
      "root_volume_type",
      local.workers_group_defaults["root_volume_type"],
      )
      iops = lookup(
      var.worker_groups_launch_template[count.index],
      "root_iops",
      local.workers_group_defaults["root_iops"],
      )
      encrypted = lookup(
      var.worker_groups_launch_template[count.index],
      "root_encrypted",
      local.workers_group_defaults["root_encrypted"],
      )
      kms_key_id = lookup(
      var.worker_groups_launch_template[count.index],
      "root_kms_key_id",
      local.workers_group_defaults["root_kms_key_id"],
      )
      delete_on_termination = true
    }
  }

  tag_specifications {
    resource_type = "volume"

    tags = merge(
    {
      "Name" = "${var.platform_name}-${lookup(
          var.worker_groups_launch_template[count.index],
          "name",
          count.index,
        )}-_asg"
    },
    var.tags,
    )
  }

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}