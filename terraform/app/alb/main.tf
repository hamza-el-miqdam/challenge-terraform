resource "aws_lb" "main" {
  name               = "${var.app_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.main.id, aws_security_group.alb_health.id]
  subnets            = var.public_subnet_ids
}
