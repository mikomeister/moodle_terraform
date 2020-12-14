output "dns" {
  value = aws_lb.infra.dns_name
}
output "target_group_arn" {
  value = aws_lb_target_group.infra_http.arn
}