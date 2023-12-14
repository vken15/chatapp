const { DataTypes } = require('sequelize');

module.exports = model;

function model(sequelize) {
    const attributes = {
        sender: { type: DataTypes.INTEGER, allowNull: false },
        content: { type: DataTypes.STRING, allowNull: false },
        receiver: { type: DataTypes.INTEGER, allowNull: false },
        chatId: { type: DataTypes.INTEGER, allowNull: false },
    };

    const options = {
        defaultScope: {
            // exclude hash by default
            attributes: { exclude: ['hash'] }
        },
        scopes: {
            // include hash with this scope
            withHash: { attributes: {}, }
        }
    };

    return sequelize.define('Message', attributes, options);
}