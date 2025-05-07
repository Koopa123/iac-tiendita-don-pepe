# Proyecto: Infraestructura como Código – Sistema para Minimarkets

Este proyecto despliega una arquitectura serverless en AWS utilizando Terraform, simulando un sistema básico para gestión de productos en una cadena de minimarkets. El enfoque es demostrar el uso de integraciones entre servicios como Lambda, API Gateway, DynamoDB, CloudWatch, S3 y CloudFront.

---

## 🚀 Servicios utilizados

| Servicio AWS         | Uso principal                                                                 |
|----------------------|-------------------------------------------------------------------------------|
| Lambda               | Función `guardar_producto` que inserta productos en DynamoDB                 |
| DynamoDB             | Almacenamiento NoSQL de productos                                             |
| API Gateway          | Exposición pública de la Lambda mediante endpoint REST `/productos`          |
| CloudWatch Events    | Trigger cada minuto (para pruebas o ejecución programada)                    |
| S3                   | Almacenamiento de archivos estáticos (`index.html`)                          |
| CloudFront           | CDN que sirve el frontend almacenado en S3                                   |
| IAM Roles & Policies | Permisos para que Lambda acceda a DynamoDB y reciba eventos                  |

---

## ✅ Requisitos cumplidos

- [x] **Lambda + DynamoDB**
- [x] **Lambda + CloudWatch trigger (cada minuto)**
- [x] **Lambda + API Gateway (proxy REST)**
- [x] **S3 + CloudFront para servir frontend**
- [x] **Variables y salidas definidas en Terraform**
- [x] **Código empaquetado en `.zip` e invocado automáticamente**
- [x] **IAM Role con políticas necesarias para ejecución de Lambda**

---

## 🧪 Pruebas realizadas

### 🌐 Frontend en CloudFront

URL:  
`https://<tu-cloudfront-id>.cloudfront.net/`  
> Sirve `index.html` desde S3 mediante CloudFront.

### 🧾 Endpoint API Gateway (POST a productos)

URL:  
`https://<tu-api-id>.execute-api.us-east-2.amazonaws.com/prod/productos`

#### Ejemplo con `curl`:

```bash
curl -X POST https://<API_URL>/prod/productos \
  -H "Content-Type: application/json" \
  -d '{"id": "1", "nombre": "Galleta", "precio": 2.5}'


Respuesta esperada: 

Producto Galleta guardado en DynamoDB

Eliminación de recursos:

terraform destroy
