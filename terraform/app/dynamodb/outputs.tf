output "dynamodb_table_arn" {
  description = "Dynamodb table arn"
  value       = aws_dynamodb_table.books.arn
}
