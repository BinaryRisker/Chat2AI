const express = require('express');
const { authenticate } = require('../middleware/auth');
const User = require('../models/user');
const { validateRequest } = require('../middleware/validation');
const { updateUserSchema } = require('../validation/users');

const router = express.Router();

// 获取当前用户信息
router.get('/me', authenticate, async (req, res) => {
  try {
    res.json(req.user);
  } catch (err) {
    console.error('Get user error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// 更新用户信息
router.put('/me', authenticate, validateRequest(updateUserSchema), async (req, res) => {
  try {
    const updates = Object.keys(req.body);
    updates.forEach(update => (req.user[update] = req.body[update]));
    await req.user.save();
    res.json(req.user);
  } catch (err) {
    console.error('Update user error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// 删除当前用户
router.delete('/me', authenticate, async (req, res) => {
  try {
    await req.user.remove();
    res.json({ message: 'User deleted successfully' });
  } catch (err) {
    console.error('Delete user error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

module.exports = router;