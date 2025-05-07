const AWS = require("aws-sdk");
const dynamodb = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
  let body = typeof event.body === "string" ? JSON.parse(event.body) : event.body;

  const { id, nombre, descripcion, cantidad, habilitado } = body;

  const params = {
    TableName: process.env.TABLE_NAME,
    Item: {
      id,
      nombre,
      descripcion,
      cantidad,
      habilitado
    }
  };

  try {
    await dynamodb.put(params).promise();
    return {
      statusCode: 200,
      body: habilitado
        ? `✅ Producto ${nombre} creado correctamente`
        : `🛑 Producto ${nombre} deshabilitado`
    };
  } catch (err) {
    return {
      statusCode: 500,
      body: "Error al guardar: " + err
    };
  }
};
