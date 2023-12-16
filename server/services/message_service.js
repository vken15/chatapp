const db = require('_helpers/db');

module.exports = {
    getAllById,
    create,
};

async function create(params) {
    // save message
    var message = await db.Message.create(params);
    //const sender = await db.User.findByPk(params.senderId);

    //const receiver = await db.User.findByPk(params.receiverId);

    // update chat
    await db.Chat.update({ latestMessage: message.id }, { where: { id: params.chatId } });
    //const chat = await db.Chat.findByPk(params.chatId);
    // var fullmessage = {
    //     id: message.id,
    //     sender: sender,
    //     content: message.content,
    //     receiver: message.receiverId,
    //     chat: chat
    // }
    return message;
}

async function getAllById(id, pageNumber) {
    const pageSize = 12; //Số tin nhắn hiển thị mỗi trang
    const page = pageNumber || 1; //Trang hiện tại
    return await db.Message.findAll({
        where: { chatId: id },
        order: [['createdAt', 'ASC']],
        limit: pageSize,
        offset: (page - 1) * pageSize,
    });
}