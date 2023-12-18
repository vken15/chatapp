const db = require('_helpers/db');

module.exports = {
    getByTwoUserId,
    getByUserId,
    create,
};

async function create(params) {
    var chat = await db.Chat.create(params, { include: db.User });
    params.users.forEach(async element => {
        const user = await db.User.findByPk(element.id);
        chat.addUser(user);
    });
    return chat;
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
        console.log(chat.Chats[0] == undefined);
    if (chat.Chats[0] == undefined) {
        return null;
    } else {
        return await db.Chat.findByPk(chat.Chats[0].id, {include: db.User});
    }
}