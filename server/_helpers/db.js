const tedious = require('tedious');
const { Sequelize } = require('sequelize');

const { dbName, dbConfig } = require('config.json');

module.exports = db = {};

initialize();

async function initialize() {
    const dialect = 'mssql';
    const host = dbConfig.server;
    const { userName, password } = dbConfig.authentication.options;

    // create db if it doesn't already exist
    await ensureDbExists(dbName);

    // connect to db
    const sequelize = new Sequelize(dbName, userName, password, { host, dialect });

    // init models and add them to the exported db object
    db.User = require('../models/user_model')(sequelize);
    db.Message = require('../models/message_model')(sequelize);
    db.Chat = require('../models/chat_model')(sequelize);
    db.User_Chat = require('../models/user_chat_model')(sequelize);
    db.Message.belongsTo(db.User, {as: 'sender', foreignKey: 'senderId'});
    db.Message.belongsTo(db.User, {as: 'receiver', foreignKey: 'receiverId', onDelete: "NO ACTION"});
    db.User.belongsToMany(db.Chat, {through: db.User_Chat});
    db.Chat.belongsToMany(db.User, {through: db.User_Chat});
    db.Chat.hasMany(db.Message, {foreignKey: 'chatId'});
    db.Message.belongsTo(db.Chat, {foreignKey: 'chatId'});

    // sync all models with database
    await sequelize.sync({ alter: true });
}

async function ensureDbExists(dbName) {
    return new Promise((resolve, reject) => {
        const connection = new tedious.Connection(dbConfig);
        connection.connect((err) => {
            if (err) {
                console.error(err);
                reject(`Connection Failed: ${err.message}`);
            }

            const createDbQuery = `IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = '${dbName}') CREATE DATABASE [${dbName}];`;
            const request = new tedious.Request(createDbQuery, (err) => {
                if (err) {
                    console.error(err);
                    reject(`Create DB Query Failed: ${err.message}`);
                }

                // query executed successfully
                resolve();
            });

            connection.execSql(request);
        });
    });
}