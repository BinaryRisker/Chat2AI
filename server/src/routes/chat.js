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
/**
 * @swagger
 * /chat:
 *   get:
 *     summary: 获取用户所有会话
 *     tags: [Chat]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: 成功获取会话列表
 */
router.get('/', authenticate, chatController.getConversations);
module.exports = router;