const express = require('express');
const router = express.Router();
const Joi = require('joi');

const validateRequest = require('_middleware/validate-request');
const authorize = require('_middleware/authorize');
const messageService = require('services/message_service');

// routes
router.post('/', authorize(), messageSchema, sendMessage);
router.get('/:id', authorize(), getAllMessage);

module.exports = router;

function messageSchema(req, res, next) {
    const schema = Joi.object({
        senderId: Joi.number().integer().required(),
        content: Joi.string().required(),
        receiverId: Joi.number().integer().required(),
        chatId: Joi.number().integer().required()
    });
    validateRequest(req, next, schema);
}

function getAllMessage(req, res, next) {
    messageService.getAllById(req.params.id, req.query.page)
        .then((message) => res.json(message))
        .catch(() => res.status(500).json({ error: 'Không tải được tin nhắn' }));
}

function sendMessage(req, res, next) {
    messageService.create(req.body)
        .then((message) => {
            res.json(message);
            //res.json({ message: 'Đã gửi' });
        })
        .catch(() => {
            res.status(500).json({ error: 'Không gửi được tin nhắn' });
        });
}