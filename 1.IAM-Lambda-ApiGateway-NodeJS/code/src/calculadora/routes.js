var calculadora = require('./calculadoracontroller');

module.exports = function(app) {
    app.route('/soma')
       .post(calculadora.somar);

    app.route('/subtracao')
       .post(calculadora.subtrair);

    app.route('/divisao')
       .post(calculadora.dividir);

    app.route('/multiplicacao')
       .post(calculadora.multiplicar);
};