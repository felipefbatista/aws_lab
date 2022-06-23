const somar = async (req, res) => {
  const model = req.body;
  
  var response = model.primeiro + model.segundo;

  return res.status(200).json({ result: response });
};

const subtrair = async (req, res) => {
  const model = req.body;
  
  var response = model.primeiro - model.segundo;

  return res.status(200).json({ result: response });
};

const dividir = async (req, res) => {
  const model = req.body;
  
  var response = model.primeiro / model.segundo;

  return res.status(200).json({ result: response });
};

const multiplicar = async (req, res) => {
  const model = req.body;
  
  var response = model.primeiro * model.segundo;

  return res.status(200).json({ result: response });
};

module.exports = {
  somar,
  subtrair,
  dividir,
  multiplicar,
};