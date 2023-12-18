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

function accessChatSchema(req, res, next) {
    const schema = Joi.object({
        userId: Joi.number().integer().required(),
    });
    validateRequest(req, next, schema);
}

function accessChat(req, res, next) {
    chatService.getByTwoUserId(req.body.userId, req.auth.sub).then((isChat) => {
        if (isChat != null) {
            res.json(isChat);
        }
        else {
            console.log("CREATE");
            var Chat = {
                chatName: "",
                isGroupChat: false,
                users: [
                    {
                        id: parseInt(req.body.userId),
                        User_Chats: {
                        }
                    },
                    {
                        id: parseInt(req.auth.sub),
                        User_Chats: {
                        }
                    }
                ]
            };
            chatService.create(Chat)
                .then((chat) => res.json(chat))
                .catch(() => res.status(500).json({ error: 'Không tạo được' }));
        }
    });
}

function getChat(req, res, next) {
    chatService.getByUserId(req.auth.sub)
        .then(chat => res.json(chat))
        .catch(next);
}