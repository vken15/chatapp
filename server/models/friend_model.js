const { DataTypes } = require('sequelize');

module.exports = model;

function model(sequelize) {
    const attributes = {
        status: { type: DataTypes.INTEGER, allowNull: false }, //status -1: reject, 1: request, 2: accept
    };

    return sequelize.define('Friend', attributes);
}