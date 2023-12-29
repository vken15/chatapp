const db = require('_helpers/db');
const e = require('cors');
const { Op, where } = require("sequelize");

module.exports = {
    create,
    update,
    getById,
    acceptFriend,
    getAllFriend,
    getAllRFR, //received friend request
    getAllSFR, //sended friend request
    delete: _delete,
};

async function create(params) {
    const friend = await db.Friend.create(params);
    return friend;
}

async function update(params) {
    const friend = await getFriend(params.userId, params.friendId);
    friend.status = params.status;
    await friend.save();
    return friend;
}

async function getById(id, friendId) {
    const friend = await db.Friend.findOne(
        { where: { userId: id, friendId: friendId } }
    );
    if (friend != null) {
        return friend.status;
    }
    else {
        return 0;
    }
}

async function getAllRFR(id) {
    const user = await db.User.findOne(
        {
            include: {
                model: db.User, as: 'owner',
                include: {
                    model: db.Friend, as: "Friends",
                    where: { status: { [Op.in]: [1, -1] } }
                }
            },
            where: { id: id }
        }
    );
    if (user != null) {
        const list = user.owner;
        return list;
    }
    else {
        throw "Không tồn tại";
    }
}

async function getAllFriend(id) {
    const user = await db.User.findOne(
        {
            include: {
                model: db.User, as: 'friend',
                include: {
                    model: db.Friend, as: "Friends",
                    attributes: ['status'],
                    where: { status: 2 }
                }
            },
            where: { id: id }
        }
    );
    if (user != null) {
        const list = user.friend;
        return list;
    }
    else {
        throw "Không tồn tại";
    }
}

async function getAllSFR(id) {
    const user = await db.User.findOne(
        {
            include: {
                model: db.User, as: 'friend',
                include: {
                    model: db.Friend, as: "Friends",
                    where: { status: { [Op.in]: [1, -1] } }
                }
            },
            where: { id: id }
        }
    );
    if (user != null) {
        const list = user.friend;
        return list;
    }
    else {
        throw "Không tồn tại";
    }
}

async function acceptFriend(params) {
    const friendRequest = await db.Friend.findOne(
        { where: { userId: params.userId, friendId: params.friendId } }
    );
    if (friendRequest == null) {
        await db.Friend.create(params);
        const friend = await getFriend(params.friendId, params.userId);
        friend.status = params.status;
        await friend.save();
        return "Kết bạn thành công";
    }
    return "Error";
}

async function _delete(params) {
    const friend = await db.Friend.findOne(
        { where: { userId: params.userId, friendId: params.friendId } }
    );
    if (friend != null) await friend.destroy();
    const friend2 = await db.Friend.findOne(
        { where: { userId: params.friendId, friendId: params.userId } }
    );
    if (friend2 != null) await friend2.destroy();
}

// helper functions

async function getFriend(id, friendId) {
    const friend = await db.Friend.findOne(
        { where: { userId: id, friendId: friendId } }
    );
    if (!friend) throw 'Không tồn tại';
    return friend;
}