const { DataTypes, Model } = require('sequelize');
const { sequelize } = require('../db');

class Message extends Model {}

Message.init({
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  content: {
    type: DataTypes.TEXT,
    allowNull: false,
  },
  role: {
    type: DataTypes.ENUM('user', 'model', 'system'),
    allowNull: false,
  },
  // conversationId and userId are foreign keys
}, {
  sequelize,
  modelName: 'Message',
});

module.exports = Message;