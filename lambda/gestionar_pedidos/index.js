const AWS = require("aws-sdk");
const dynamodb = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
  const body = typeof event.body === "string" ? JSON.parse(event.body) : event.body;
  const { id, productos, fecha } = body;

  const productosDisponibles = [];

  for (const p of productos) {
    const producto = await dynamodb.get({
      TableName: process.env.PRODUCTOS_TABLE,
      Key: { id: p.id }
    }).promise();

    if (producto.Item && producto.Item.habilitado && producto.Item.cantidad >= p.cantidad) {
      productosDisponibles.push(p);
    } else {
      return {
        statusCode: 400,
        body: `Producto ${p.id} no disponible o stock insuficiente`
      };
    }
  }

  // Descontar stock
  for (const p of productosDisponibles) {
    await dynamodb.update({
      TableName: process.env.PRODUCTOS_TABLE,
      Key: { id: p.id },
      UpdateExpression: "SET cantidad = cantidad - :cant",
      ExpressionAttributeValues: {
        ":cant": p.cantidad
      }
    }).promise();
  }

  // Guardar pedido
  await dynamodb.put({
    TableName: process.env.PEDIDOS_TABLE,
    Item: {
      id,
      productos: productosDisponibles,
      fecha
    }
  }).promise();

  return {
    statusCode: 200,
    body: "🛒 Pedido registrado correctamente"
  };
};
