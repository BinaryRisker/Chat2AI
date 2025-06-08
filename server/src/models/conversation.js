const { DataTypes, Model } = require('sequelize');
const { sequelize } = require('../db');

class Conversation extends Model {}

Conversation.init({
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  title: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  // userId is a foreign key, will be defined in associations
}, {
  sequelize,
  modelName: 'Conversation',
});

module.exports = Conversation;