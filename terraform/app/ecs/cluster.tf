resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-ecs-cluster"
}
