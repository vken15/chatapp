const { DataTypes } = require('sequelize');

module.exports = model;

function model(sequelize) {
    const attributes = {
    };

    return sequelize.define('User_Chat', attributes);
}