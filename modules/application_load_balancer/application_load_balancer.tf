resource "aws_lb" "infra" {
  name                             = format("%s-infra-alb", var.platform_name)
  internal                         = false
  subnets                          = var.subnets
  load_balancer_type               = "application"
  enable_cross_zone_load_balancing = true
  enable_http2                     = false

  security_groups = var.sg_id
  tags = map("Name", var.platform_name)

}

resource "aws_lb_listener" "infra_http" {
  load_balancer_arn = aws_lb.infra.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.infra_http.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "infra_https" {
  load_balancer_arn = aws_lb.infra.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.infra_http.arn
    type             = "forward"
  }
}