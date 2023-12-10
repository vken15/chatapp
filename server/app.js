require('rootpath')();
const express = require("express");
const app = express();
const cors = require('cors');

const errorHandler = require('_middleware/error-handler');

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());

// api routes
app.use('/users', require('./controllers/users_controller'));

// global error handler
app.use(errorHandler);

module.exports = app;