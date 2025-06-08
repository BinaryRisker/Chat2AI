const mongoose = require('mongoose');

const messageSchema = new mongoose.Schema({
  conversationId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Conversation',
    required: true
  },
  content: {
    type: String,
    required: true,
    text: true // 添加全文索引
  },
  role: {
    type: String,
    required: true,
    enum: ['user', 'assistant', 'system']
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
});

// 添加全文索引
messageSchema.index({ content: 'text' });

module.exports = mongoose.model('Message', messageSchema);