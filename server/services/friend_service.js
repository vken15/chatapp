const db = require('_helpers/db');

module.exports = {
    create,
    update,
    //delete: _delete
};

async function create(params) {
    const friend = await db.Friend.create(params);
    return friend;
}

async function update(params) {
    const friend = getFriend(params.userId, params.friendId);
    friend.status = params.status;
    await friend.save();
    return friend;
}

// helper functions

async function getFriend(id, friendId) {
    const friend = await db.Friend.findOne(
        {where: { userId: id, friendId: friendId }}
    );
    if (!friend) throw 'Không tồn tại';
    return friend;
}