resource "aws_dynamodb_table" "productos" {
  name         = "Productos"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "Productos"
    Environment = "dev"
  }
}
