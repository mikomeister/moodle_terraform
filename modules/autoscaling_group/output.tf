
output "workers_asg_arns" {
  description = "IDs of the autoscaling groups containing workers."
  value = concat(
  aws_autoscaling_group.main_asg.*.arn
  )
}

output "workers_asg_names" {
  description = "Names of the autoscaling groups containing workers."
  value = concat(
  aws_autoscaling_group.main_asg.*.id
  )
}

output "workers_launch_template_ids" {
  description = "IDs of the worker launch templates."
  value       = aws_launch_template.workers_launch_template.*.id
}

output "workers_launch_template_arns" {
  description = "ARNs of the worker launch templates."
  value       = aws_launch_template.workers_launch_template.*.arn
}

output "workers_launch_template_latest_versions" {
  description = "Latest versions of the worker launch templates."
  value       = aws_launch_template.workers_launch_template.*.latest_version
}
