const express = require('express');
const router = express.Router();
const Joi = require('joi');

const validateRequest = require('_middleware/validate-request');
const authorize = require('_middleware/authorize');
const messageService = require('services/message_service');
const chatService = require('services/chat_service');
const Message = require("models/message_model");

// routes
router.post('/', authorize(), messageSchema, sendMessage);
router.get('/:id', authorize(), getAllMessage);

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

function getAllMessage(req, res, next) {
    try {
        const pageSize = 12; //Số tin nhắn hiển thị mỗi trang
        const page = req.query.page || 1; //Trang hiện tại

        //
        const skipMessages = (page - 1) * pageSize;

        //Tim tin nhan theo trang sap xep moi nhat
        //var message = await Message.find({chat: req.params.id})

        //res.json(message);
    }
    catch (e) {
        res.status(500).json({ error: "Không tải được tin nhắn"});
    }
}

function sendMessage(req, res, next) {
    messageService.create(req.body)
        .then(() => {
            //res.json(message);
            res.status(200).json({ message: 'Đã gửi' });
            //update chat
        })
        .catch(() => {
            res.status(500).json({ error: 'Không gửi được tin nhắn' });
        });
}