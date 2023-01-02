output "secretsmanager_arn" {
  description = "Arn of the secretsmanager for the books app"
  value       = aws_secretsmanager_secret.main.arn
}
