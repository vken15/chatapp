const db = require('_helpers/db');
const { Op } = require("sequelize");

module.exports = {
    create,
    update,
    getById,
    getAllRFR, //received friend request
    getAllSFR, //sended friend request
    //delete: _delete
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
                model: db.User, as: 'owner', through: {
                    attributes: ['status'], where: {status: {[Op.in]: [1, -1]}}
                }
            }, where: { id: id }
        }
    );
    if (user != null) {
        const list = user.getOwner({ joinTableAttributes: ['status'] });
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
                model: db.User, as: 'friend', through: {
                    attributes: ['status'], where: {status: {[Op.in]: [1, -1]}}
                }
            }, where: { id: id }
        }
    );
    const list = user.getFriend({ joinTableAttributes: ['status'] });
    return list;
}

// helper functions

async function getFriend(id, friendId) {
    const friend = await db.Friend.findOne(
        { where: { userId: id, friendId: friendId } }
    );
    if (!friend) throw 'Không tồn tại';
    return friend;
}