//resource "aws_lb_target_group" "infra_https" {
//  name                 = format("%s-infra-alb-https", var.platform_name)
//  port                 = 443
//  protocol             = "HTTPS"
//  deregistration_delay = 20
//  vpc_id               = var.vpc_id
//  stickiness {
//    type            = "lb_cookie"
//    cookie_duration = 3600
//    enabled         = true
//  }
//  tags = map("Name", format("%s-infra", var.platform_name))
//}