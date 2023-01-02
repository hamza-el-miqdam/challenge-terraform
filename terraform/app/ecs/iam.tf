resource "aws_iam_role" "task_execution" {
  name = "${var.app_name}-task-execution-role"

  assume_role_policy = data.aws_iam_policy_document.task_execution_assume_role.json

  inline_policy {
    name   = "main"
    policy = data.aws_iam_policy_document.task_execution.json
  }
}

data "aws_iam_policy_document" "task_execution" {
  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer"
    ]

    resources = ["*"]
  }
  statement {
    actions = [
      "kms:Decrypt",
      "secretsmanager:GetSecretValue",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "task_execution_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "task_role" {
  name = "${var.app_name}-task-role"

  assume_role_policy = data.aws_iam_policy_document.task_assume_role.json

  inline_policy {
    name   = "main"
    policy = data.aws_iam_policy_document.task_role.json
  }
}

data "aws_iam_policy_document" "task_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "task_role" {
  statement {
    sid = "DynamoDbTableAccess"

    actions = [
      "dynamodb:PutItem",
      "dynamodb:Scan",
    ]

    resources = [
      var.dynamodb_table_arn,
    ]
  }
}
