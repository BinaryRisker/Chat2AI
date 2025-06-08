const express = require('express');
const { validateRequest } = require('../middleware/validation');
const { loginSchema, registerSchema } = require('../validation/auth');
const authController = require('../controllers/auth.controller');

const router = express.Router();

router.post('/login', validateRequest(loginSchema), authController.login);

router.post('/register', validateRequest(registerSchema), authController.register);

module.exports = router;