const express = require('express');
const { authenticate } = require('../middleware/auth');
const Conversation = require('../models/conversation');
const Message = require('../models/message');
const { validateRequest } = require('../middleware/validation');
const { createConversationSchema, sendMessageSchema } = require('../validation/chat');

const router = express.Router();

// 获取用户所有会话
router.get('/', authenticate, async (req, res) => {
  try {
    const conversations = await Conversation.find({ userId: req.user._id })
      .sort({ updatedAt: -1 });
    res.json(conversations);
  } catch (err) {
    console.error('Get conversations error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// 创建新会话
router.post('/', authenticate, validateRequest(createConversationSchema), async (req, res) => {
  try {
    const conversation = new Conversation({
      userId: req.user._id,
      title: req.body.title || 'New Chat',
    });
    await conversation.save();
    res.status(201).json(conversation);
  } catch (err) {
    console.error('Create conversation error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// 获取会话详情
router.get('/:id', authenticate, async (req, res) => {
  try {
    const conversation = await Conversation.findOne({
      _id: req.params.id,
      userId: req.user._id,
    });
    
    if (!conversation) {
      return res.status(404).json({ error: 'Conversation not found' });
    }
    
    const messages = await Message.find({ conversationId: conversation._id })
      .sort({ createdAt: 1 });
    
    res.json({ ...conversation.toObject(), messages });
  } catch (err) {
    console.error('Get conversation error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// 发送消息
router.post('/:id/messages', authenticate, validateRequest(sendMessageSchema), async (req, res) => {
  try {
    const conversation = await Conversation.findOne({
      _id: req.params.id,
      userId: req.user._id,
    });
    
    if (!conversation) {
      return res.status(404).json({ error: 'Conversation not found' });
    }
    
    const message = new Message({
      conversationId: conversation._id,
      content: req.body.content,
      role: req.body.role || 'user',
    });
    
    await message.save();
    conversation.updatedAt = new Date();
    await conversation.save();
    
    res.status(201).json(message);
  } catch (err) {
    console.error('Send message error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// 删除会话
router.delete('/:id', authenticate, async (req, res) => {
  try {
    const result = await Conversation.deleteOne({
      _id: req.params.id,
      userId: req.user._id,
    });
    
    if (result.deletedCount === 0) {
      return res.status(404).json({ error: 'Conversation not found' });
    }
    
    await Message.deleteMany({ conversationId: req.params.id });
    
    res.json({ message: 'Conversation deleted successfully' });
  } catch (err) {
    console.error('Delete conversation error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;