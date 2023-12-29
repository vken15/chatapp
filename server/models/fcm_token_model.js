const { DataTypes } = require('sequelize');

module.exports = model;

function model(sequelize) {
    const attributes = {
        fcm: { type: DataTypes.STRING, allowNull: false },
    };

    return sequelize.define('Token', attributes, { timestamps: false });
}