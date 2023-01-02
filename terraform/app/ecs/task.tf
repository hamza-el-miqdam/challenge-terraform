resource "aws_ecs_task_definition" "main" {
  family = var.app_name

  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.task_execution.arn
  task_role_arn            = aws_iam_role.task_role.arn
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512

  container_definitions = jsonencode([
    {
      name      = var.app_name
      image     = "${data.aws_ecr_repository.this.repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = var.application_port
          hostPort      = var.application_port
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logdriver = "awsfirelens"
        options = {
          Name     = "newrelic",
          endpoint = "https://log-api.eu.newrelic.com/log/v1"
        },
        secretOptions = [{
          name      = "apiKey",
          valueFrom = "${local.secret_arn}:NRIA_LICENSE_KEY::"
        }]
      }
    },
    {
      environment = [
        {
          name  = "NRIA_OVERRIDE_HOST_ROOT",
          value = ""
        },
        {
          name  = "NRIA_IS_FORWARD_ONLY",
          value = "true"
        },
        {
          name  = "FARGATE",
          value = "true"
        },
        {
          name  = "NRIA_PASSTHROUGH_ENVIRONMENT",
          value = "ECS_CONTAINER_METADATA_URI,ECS_CONTAINER_METADATA_URI_V4,FARGATE"
        },
        {
          name  = "NRIA_CUSTOM_ATTRIBUTES",
          value = "{\"nrDeployMethod\":\"downloadPage\"}"
        }
      ],
      secrets = [
        {
          name = "NRIA_LICENSE_KEY",
          valueFrom = "${local.secret_arn}:NRIA_LICENSE_KEY::"
        },
      ]
      cpu               = 256,
      memoryReservation = 512,
      image             = "newrelic/nri-ecs:1.9.7",
      name              = "newrelic-infra"
    },
    {
      essential = true,
      image     = "533243300146.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/newrelic/logging-firelens-fluentbit",
      name      = "log_router",
      firelensConfiguration = {
        type = "fluentbit",
        options = {
          enable-ecs-log-metadata = "true",
        }
      }
    }
  ])

  depends_on = [
    aws_iam_role.task_execution
  ]
}
