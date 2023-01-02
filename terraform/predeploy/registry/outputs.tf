output "books_ecr_arn" {
  description = "Arn of the repo for the books app"
  value       = aws_ecr_repository.main.arn
}

output "books_ecr_repository_url" {
  description = "Repository url of the books app"
  value       = aws_ecr_repository.main.repository_url
}
