const express = require('express');
const router = express.Router();

const authorize = require('_middleware/authorize')
const friendService = require('services/friend_service');

// routes
router.post('/add', authorize(), friendRequest);
router.post('/accept', authorize(), acceptFriend);
router.post('/reject', authorize(), rejectFriend);
//router.get('/', authorize(), getAll);

module.exports = router;

function friendRequest(req, res, next) {
    const model = {
        userId: req.auth.sub,
        friendId: req.body.userId,
        status: 1
    }
    friendService.create(model)
        .then(() => res.json("Đã gửi lời mời kết bạn"))
        .catch(next);
}

function acceptFriend(req, res, next) {
    const model = {
        userId: req.auth.sub,
        friendId: req.body.userId,
        status: 2
    }
    friendService.update(model)
        .then(() => res.json("Kết bạn thành công"))
        .catch(next);
}

function rejectFriend(req, res, next) {
    const model = {
        userId: req.auth.sub,
        friendId: req.body.userId,
        status: -1
    }
    friendService.update(model)
        .then(() => res.json("Đã từ chối lời mời kết bạn"))
        .catch(next);
}