require('rootpath')();
const express = require("express");
const app = express();
const cors = require('cors');

const errorHandler = require('_middleware/error-handler');

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());

// api routes
//app.use('/api/', require('./controllers/auth_controller'));
app.use('/api/users', require('./controllers/users_controller'));
app.use('/api/messages', require('./controllers/message_controller'));
app.use('/api/chats', require('./controllers/chat_controller'));

// global error handler
app.use(errorHandler);

module.exports = app;