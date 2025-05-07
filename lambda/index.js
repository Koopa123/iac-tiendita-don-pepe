const AWS = require("aws-sdk");
const dynamodb = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event) => {
  let body = event.body;

  if (typeof body === "string") {
    body = JSON.parse(body);
  }

  const { id, nombre, precio } = body;

  const params = {
    TableName: process.env.TABLE_NAME,
    Item: {
      id: id,
      nombre: nombre,
      precio: precio
    }
  };

  try {
    await dynamodb.put(params).promise();
    return {
      statusCode: 200,
      body: `Producto ${nombre} guardado en DynamoDB`
    };
  } catch (err) {
    return {
      statusCode: 500,
      body: "Error al guardar: " + err
    };
  }
};
