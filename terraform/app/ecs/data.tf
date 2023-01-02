data "aws_ecr_repository" "this" {
  name = var.ecr_repository_name
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

locals {
  secret_arn = "arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:${var.secret_name}"
}