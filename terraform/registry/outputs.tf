output "books_ecr_arn" {
  description = "Arn of the repo for the books app"
  value       = aws_ecr_repository.books_ecr.arn
}

output "books_ecr_repository_url" {
  description = "Repository url of the books app"
  value       = aws_ecr_repository.books_ecr.repository_url
}
