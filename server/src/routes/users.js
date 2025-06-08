const express = require('express');
const { authenticate } = require('../middleware/auth');
const { validateRequest } = require('../middleware/validation');
const { updateUserSchema } = require('../validation/users');
const usersController = require('../controllers/users.controller');

const router = express.Router();

// 获取当前用户信息
router.get('/me', authenticate, usersController.getUserProfile);

// 更新用户信息
router.put('/me', authenticate, validateRequest(updateUserSchema), usersController.updateUserProfile);

// 删除当前用户
router.delete('/me', authenticate, usersController.deleteUserProfile);

module.exports = router;