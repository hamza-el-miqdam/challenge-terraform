resource "aws_ecs_service" "main" {
  name            = var.app_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  launch_type     = "FARGATE"

  desired_count = 1

  network_configuration {
    security_groups = [aws_security_group.ecs_tasks.id]
    subnets         = var.private_subnet_ids
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "bookstore"
    container_port   = var.application_port
  }
}
