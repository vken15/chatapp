const db = require('_helpers/db');

module.exports = {
    getByTwoUserId,
    getByUserId,
    create,
};

async function create(params) {
    var chat = await db.Chat.create(params);
    const user = await db.User.findByPk(params.Users[0].id);
    await chat.addUser(user);
    const user2 = await db.User.findByPk(params.Users[1].id);
    await chat.addUser(user2);
    return await db.Chat.findByPk(chat.id, {include: db.User});
}

async function getByUserId(userId) {
    const chatList = await db.User.findOne({
        attributes: { exclude: ['id', 'username', 'fullName', 'createdAt', 'updatedAt'] },
        include: {
            model: db.Chat,
            include: [db.User, {model: db.Message, order: [['createdAt', 'DESC']], limit: 1}],
        }, where: { id: userId }
    });
    return chatList.Chats;
}

async function getByTwoUserId(id, userId) {
    const chat = await db.User.findOne({
        attributes: { exclude: ['id', 'username', 'fullName', 'createdAt', 'updatedAt'] },
        include: {
            model: db.Chat,
            include: {model: db.User, where: {id: id}},
        },
        where: {id: userId}});
    if (chat.Chats[0] == undefined) {
        return null;
    } else {
        return await db.Chat.findByPk(chat.Chats[0].id, {include: db.User});
    }
}