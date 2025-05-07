variable "region" {
  description = "Región donde se desplegarán los recursos en AWS"
  type        = string
  default     = "us-east-2"
}

variable "table_name" {
  description = "Nombre de la tabla DynamoDB que usará la función Lambda"
  type        = string
  default     = "Productos"
}


