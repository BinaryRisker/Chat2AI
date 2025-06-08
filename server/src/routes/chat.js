const express = require('express');
const { authenticate } = require('../middleware/auth');
const { validateRequest } = require('../middleware/validation');
const { createConversationSchema } = require('../validation/chat');
const chatController = require('../controllers/chat.controller');

const router = express.Router();

// 获取用户所有会话
router.get('/', authenticate, chatController.getConversations);

// 创建新会话
router.post('/', authenticate, validateRequest(createConversationSchema), chatController.createConversation);

// 搜索会话和消息
router.get('/search', authenticate, chatController.searchConversations);

module.exports = router;