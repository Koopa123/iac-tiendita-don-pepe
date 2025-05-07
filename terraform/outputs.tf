output "lambda_function_guardar_producto" {
  description = "Nombre de la función Lambda principal"
  value       = aws_lambda_function.guardar_producto.function_name
}

output "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB"
  value       = aws_dynamodb_table.productos.name
}

output "api_gateway_url" {
  description = "URL para invocar el endpoint de productos vía API Gateway"
  value       = "https://${aws_api_gateway_rest_api.productos_api.id}.execute-api.${var.region}.amazonaws.com/prod/productos"
}

output "cloudfront_url" {
  description = "URL del frontend servida desde CloudFront"
  value       = "https://${aws_cloudfront_distribution.frontend_cdn.domain_name}"
}

