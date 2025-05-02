output "lambda_function_guardar_producto" {
  value = aws_lambda_function.guardar_producto.function_name
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.productos.name
}
