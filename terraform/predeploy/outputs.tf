output "books_ecr_arn" {
  description = "Arn of the repository for the books app"
  value       = module.registry.books_ecr_arn
}

output "books_ecr_repository_url" {
  description = "Repository url of the books app"
  value       = module.registry.books_ecr_repository_url
}

output "secretsmanager_arn" {
  description = "Arn of the secretsmanager for the books app"
  value       = module.secret-manager.secretsmanager_arn
}
