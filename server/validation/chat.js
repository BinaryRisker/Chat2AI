const { body, param } = require('express-validator');

const createConversationSchema = [
  body('title').optional().trim().isLength({ max: 100 }),
];

const sendMessageSchema = [
  param('id').isMongoId().withMessage('Invalid conversation ID'),
  body('content').notEmpty().withMessage('Message content is required'),
  body('role').optional().isIn(['user', 'assistant', 'system']),
];

module.exports = { createConversationSchema, sendMessageSchema };