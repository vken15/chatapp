const express = require('express');
const router = express.Router();
const Joi = require('joi');

const validateRequest = require('_middleware/validate-request');
const authorize = require('_middleware/authorize');
const chatService = require('services/chat_service');
const userService = require('services/user_service');

// routes
router.post('/', authorize(), accessChatSchema, accessChat);
router.get('/', authorize(), getChat);

module.exports = router;

function chatSchema(req, res, next) {
    const schema = Joi.object({
        chatName: Joi.number().integer().required(),
        isGroupChat: Joi.boolean().required(),
    });
    validateRequest(req, next, schema);
}

function accessChatSchema(req, res, next) {
    const schema = Joi.object({
        userId: Joi.number().integer().required(),
        otherUserId: Joi.number().integer().required(),
    });
    validateRequest(req, next, schema);
}

function accessChat(req, res, next) {
    chatService.findChat(req.body).then((isChat) => {
        if (isChat != null) {
            res.json(isChat);
        }
        else {
            console.log("CREATE");
            res.json("CREATE");
            var Chat = {
                chatName: "test",
                isGroupChat: false,
                users: [
                    {
                        id: parseInt(req.body.userId),
                        User_Chats: {
                        }
                    },
                    {
                        id: parseInt(req.body.otherUserId),
                        User_Chats: {
                        }
                    }
                ]
            };
            chatService.create(Chat)
                .then(() => { res.status(200).json({ message: 'Tạo thành công' }); })
                .catch(() => { res.status(500).json({ error: 'Không tạo được' }); });
        }
    }
    );
}

function getChat(req, res, next) {

}