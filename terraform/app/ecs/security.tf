resource "aws_security_group" "ecs_tasks" {
  name        = "${var.app_name}-tasks"
  description = "ECS tasks can only be access from the ALB"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = var.application_port
    to_port         = var.application_port
    security_groups = [var.alb_security_group_id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
