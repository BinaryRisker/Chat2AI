const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const { createNamespace } = require('cls-hooked');

const app = express();

// 初始化CLS命名空间用于请求上下文追踪
const traceNamespace = createNamespace('trace');
const swaggerJsdoc = require('swagger-jsdoc');
const swaggerUi = require('swagger-ui-express');

// Swagger配置
const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'Chat2AI API',
      version: '1.0.0',
    },
  },
  apis: ['./routes/*.js'], // 指定包含API路由注释的文件
};

const specs = swaggerJsdoc(options);
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(specs));

// 中间件
app.use(cors());
app.use(helmet());
app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// 路由
app.use('/api/auth', require('./routes/auth'));
app.use('/api/chat', require('./routes/chat'));
app.use('/api/users', require('./routes/users'));

// 错误处理
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Internal Server Error' });
});

module.exports = app;