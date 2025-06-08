const User = require('./user');
const Conversation = require('./conversation');
const Message = require('./message');

// Define associations
User.hasMany(Conversation, {
  foreignKey: {
    name: 'userId',
    allowNull: false,
  },
  onDelete: 'CASCADE', // If a user is deleted, all their conversations are also deleted.
});
Conversation.belongsTo(User, { foreignKey: 'userId' });

Conversation.hasMany(Message, {
  foreignKey: {
    name: 'conversationId',
    allowNull: false,
  },
  onDelete: 'CASCADE', // If a conversation is deleted, all its messages are also deleted.
});
Message.belongsTo(Conversation, { foreignKey: 'conversationId' });

User.hasMany(Message, {
  foreignKey: {
    name: 'userId',
    allowNull: false,
  },
  onDelete: 'CASCADE', // If a user is deleted, all their messages are also deleted.
});
Message.belongsTo(User, { foreignKey: 'userId' });


module.exports = {
  User,
  Conversation,
  Message,
}; 