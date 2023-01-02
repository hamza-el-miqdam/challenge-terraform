resource "aws_ecr_repository" "books_ecr" {
  name                 = "bookstore"
  image_tag_mutability = "MUTABLE"
}
