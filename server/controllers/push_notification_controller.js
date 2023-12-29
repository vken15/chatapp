var admin = require("firebase-admin");
const { getMessaging } = require("firebase-admin/messaging");
const express = require('express');
const router = express.Router();

const authorize = require('_middleware/authorize');
var serviceAccount = require("config/push-notification-key.json");
const tokenService = require('services/token_service');
const chatService = require('services/chat_service');
const userService = require('services/user_service');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

// routes
router.post('/send', authorize(), sendNotify);
router.post('/store', authorize(), storeToken);

module.exports = router;

async function sendNotify(req, res) {
  const token = await tokenService.getToken(req.body.receiverId);
  if (token == null) throw "Error"; 
  const chat = await chatService.getByTwoUserId(req.auth.sub, req.body.receiverId);
  const sender = await userService.getById(req.auth.sub);
  var title = chat.chatName;
  if (title == "" || title == null || title == undefined) {
    title = sender.fullName;
  }
  const message = {
    notification: {
      title: title,
      body: req.body.content
    },
    data: {
      chatId: `${chat.id}`,
      receiverId: `${req.auth.sub}`,
      fullName: `${sender.fullName}`,
      photo: `${sender.photo}`,
      lastOnline: `${sender.lastOnline.toISOString()}`
    },
    token: token,
  };

  getMessaging()
    .send(message)
    .then((response) => {
      res.status(200).json({
        message: "Successfully sent message",
        token: token,
      });
      console.log("Successfully sent message:", response);
    })
    .catch((error) => {
      res.status(400);
      res.send(error);
      console.log("Error sending message:", error);
    });
}

function storeToken(req, res, next) {
  var model = {
    fcm: req.body.token,
    userId: req.auth.sub,
  }
  tokenService.storeToken(model)
    .then(() => res.json("success"))
    .catch(next);
}