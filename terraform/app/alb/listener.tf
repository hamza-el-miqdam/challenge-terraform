resource "aws_lb_target_group" "main" {
  name                          = var.app_name
  port                          = var.application_port
  protocol                      = "HTTP"
  target_type                   = "ip"
  vpc_id                        = var.vpc_id

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "redirect_listener" {
  load_balancer_arn = aws_lb.main.arn
  protocol          = "HTTP"
  port              = "80"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  protocol          = "HTTPS"
  port              = "443"
  certificate_arn   = module.main_acm.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}
