exports.handler = async (event) => {
    console.log("Hola Don Pepe desde Lambda");
    return {
        statusCode: 200,
        body: "Hola Don Pepe desde Lambda"
    };
};
