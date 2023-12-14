const db = require('_helpers/db');

module.exports = {
    getAllById,
    create,
};

async function create(params) {
    // save message
    await db.Message.create(params);
}

async function getAllById(id) {
    return await db.Message.findAll({ where: { chatId: id}});
}