const mongoose = require('mongoose');

const conversationSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
  title: {
    type: String,
    required: true,
    trim: true,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
  updatedAt: {
    type: Date,
    default: Date.now,
  },
});

// 更新updatedAt字段的钩子
conversationSchema.pre('save', function(next) {
  this.updatedAt = new Date();
  next();
});

conversationSchema.pre('updateOne', function(next) {
  this.set({ updatedAt: new Date() });
  next();
});

module.exports = mongoose.model('Conversation', conversationSchema);