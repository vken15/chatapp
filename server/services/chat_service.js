const db = require('_helpers/db');
const { where } = require('sequelize');

module.exports = {
    findChat,
    getAllByUser,
    create,
};

async function create(params) {
    // save message
    const chat = await db.Chat.create(params, { include: db.User });
    params.users.forEach(async element => {
        const user = await db.User.findByPk(element.id);
        chat.addUser(user);
    });
    console.log(chat);
}

async function getAllByUser(id) {
    return await db.Chat.findAll({ where: { id: id } });
}

async function findChat(params) {
    return await db.Chat.findOne({ include: { model: db.User, where: { id: [params.userId, params.otherUserId] } } },
        {
            where: isGroupChat = false,
        });
}