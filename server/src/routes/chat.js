const express = require('express');
const { authenticate } = require('../middleware/auth');
const { validateRequest } = require('../middleware/validation');
const { createConversationSchema, sendMessageSchema } = require('../validation/chat');
const SearchService = require('../services/search.service');

const router = express.Router();
const searchService = new SearchService();

// 获取用户所有会话
router.get('/', authenticate, async (req, res) => {
  try {
    const conversations = await Conversation.find({ userId: req.user._id }).sort({ updatedAt: -1 });
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
      title: req.body.title || 'New Conversation'
    });
    await conversation.save();
    res.status(201).json(conversation);
  } catch (err) {
    console.error('Create conversation error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// 搜索会话和消息
router.get('/search', authenticate, async (req, res) => {
  try {
    const { q } = req.query;
    if (!q) {
      return res.status(400).json({ error: 'Query parameter q is required' });
    }

    const results = await searchService.globalSearch(req.user._id, q);
    res.json(results);
  } catch (err) {
    console.error('Search error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// 其他现有路由保持不变...

module.exports = router;