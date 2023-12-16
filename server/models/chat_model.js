const { DataTypes } = require('sequelize');

module.exports = model;

function model(sequelize) {
    const attributes = {
        chatName: { type: DataTypes.STRING, allowNull: false },
        isGroupChat: { type: DataTypes.BOOLEAN, allowNull: false },
        //latestMessage: { type: DataTypes.INTEGER, allowNull: true },
    };

    return sequelize.define('Chat', attributes);
}