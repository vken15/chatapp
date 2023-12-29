require('rootpath')();
const express = require("express");
const app = express();
const cors = require('cors');
const bodyParser = require("body-parser");

const errorHandler = require('_middleware/error-handler');


app.use(bodyParser.json({
    limit: "10mb" //increased the limit to receive base64
}));

app.use(express.json());
app.use(bodyParser.urlencoded({
    limit: "10mb",
    extended: true,
    parameterLimit: 10000
}));
app.use(cors());
app.use('/image/users', express.static('E:/flutter/chatapp_image_folder/'));
// api routes
//app.use('/api/', require('./controllers/auth_controller'));
app.use('/api/users', require('./controllers/user_controller'));
app.use('/api/messages', require('./controllers/message_controller'));
app.use('/api/chats', require('./controllers/chat_controller'));
app.use('/api/friends', require('./controllers/friend_controller'));
app.use('/api/notify', require('./controllers/push_notification_controller'));

// global error handler
app.use(errorHandler);

module.exports = app;