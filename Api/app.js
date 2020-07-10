const express = require('express')
const app = express()
const mongoose = require('mongoose')
const Message = require('./models/msgModel')
const bodyParser = require('body-parser')

const { MONGO_URL, MONGO_USER, MONGO_PWD, MONGO_DATABASE } = process.env;

mongoose.Promise = global.Promise;
mongoose.connect(`mongodb://${MONGO_USER}:${MONGO_PWD}@${MONGO_URL}/${MONGO_DATABASE}?retryWrites=true&w=majority`, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useCreateIndex: true
}).then(() => {
    console.log( "## Successfully connected to Database");
}).catch(err => {
    console.log({
        message: `## Could not connect to Database ${MONGO_DATABASE}`,
        details: err
    });
});
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var routes = require('./routes/routes');

routes(app);

module.exports = app