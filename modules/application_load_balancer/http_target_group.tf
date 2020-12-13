resource "aws_lb_target_group" "infra_http" {
  name                 = format("%s-infra-alb-http", var.platform_name)
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 20
  vpc_id               = var.vpc_id
  stickiness {
    type            = "lb_cookie"
    cookie_duration = 3600
    enabled         = true
  }
  tags = map("Name", format("%s-infra", var.platform_name))
}