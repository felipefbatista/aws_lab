exports.handler = async (event) => {
    // TODO implement
    const response = {
        statusCode: 200,
        body: JSON.stringify('Hello from Lambda!'),
    };
    console.log("eu sou um log do cloud watch");
    console.error("eu sou um error do cloud watch");
    console.info("eu sou um info do cloud watch");

    console.log({type:"info", body:{abc:1, efg:2}});
    console.log({type:"warning", body:{abc:3, efg:4}});

    return response;
};
