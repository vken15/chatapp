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
            include: db.User,
        }, where: {id: userId} });
    // const fullChat = {
    //     id: chatList.Chats.id,
    //     chatName: chatList.Chats.chatName,
    //     isGroupChat: chatList.Chats.isGroupChat,
    //     latestMessage: chatList.Chats.Messages,
    //     createdAt: chatList.Chats.createdAt,
    //     updatedAt: chatList.Chats.updatedAt,
    //     users: chatList.Chats.Users
    // }
    return chatList.Chats;
}

async function getByTwoUserId(id, userId) {
    return await db.Chat.findOne({ include: { model: db.User, where: { id: [id, userId] } } },
        {
            where: isGroupChat = false,
        });
}