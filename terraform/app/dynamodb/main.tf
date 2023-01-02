resource "aws_dynamodb_table" "books" {
  name           = "books"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "book" {
  table_name = aws_dynamodb_table.books.name
  hash_key   = aws_dynamodb_table.books.hash_key

  item = <<ITEM
{
  "id": {"S": "694fc989-23c6-4b66-ab7a-74f7bdd3a1b3"},
  "Title": {"S": "Dune"},
  "Author": {"S": "Frank Herbert"},
  "Genre": {"S": "Science Fiction"}
}
ITEM
}