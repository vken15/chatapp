const express = require('express');
const router = express.Router();

const validateRequest = require('_middleware/validate-request');
const authorize = require('_middleware/authorize');
const messageService = require('services/message_service');
const Message = require("models/message_model");
const Chat = require("models/chat_model");
const User = require("models/user_model");

// routes
router.post('/', authorize(), messageSchema, accessChat);
router.get('/', authorize(), getChat);

module.exports = router;

function messageSchema(req, res, next) {
    const schema = Joi.object({
        sender: Joi.number().integer().required(),
        content: Joi.string().required(),
        receiver: Joi.number().integer().required(),
        chatId: Joi.number().integer().required()
    });
    validateRequest(req, next, schema);
}

function accessChat(req, res, next) {
    
}

function getChat(req, res, next) {
    //Tim chat
    //Chat
}