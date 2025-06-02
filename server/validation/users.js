const { body } = require('express-validator');

const updateUserSchema = [
  body('email').optional().isEmail().withMessage('Invalid email format'),
  body('password')
    .optional()
    .isLength({ min: 8 })
    .withMessage('Password must be at least 8 characters long'),
];

module.exports = { updateUserSchema };