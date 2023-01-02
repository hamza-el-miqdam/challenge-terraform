resource "aws_secretsmanager_secret" "main" {
  name = var.app_name
}