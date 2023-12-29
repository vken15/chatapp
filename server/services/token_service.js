const db = require('_helpers/db');

module.exports = {
    storeToken,
    getToken,
};

async function storeToken(params) {
    var model = await db.Token.findOne({ where: { userId: params.userId } });
    if (model) {
        model.fcm = params.fcm;
        await model.save();
    } else {
        await db.Token.create(params);
    }
}

async function getToken(id) {
    var model = await db.Token.findOne({ where: { userId: id } });
    console.log(model);
    if (model != null)
        return model.fcm;
    else
        return null;
}