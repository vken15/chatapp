const { DataTypes } = require('sequelize');

module.exports = model;

function model(sequelize) {
    const attributes = {
        chatName: { type: DataTypes.STRING, allowNull: false },
        isGroupChat: { type: DataTypes.BOOLEAN, allowNull: false },
    };

    return sequelize.define('Chat', attributes);
}