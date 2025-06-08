require('dotenv').config();

module.exports = {
  env: process.env.NODE_ENV || 'development',
  port: process.env.PORT || 3000,
  db: {
    uri: process.env.DB_URI || 'mongodb://localhost:27017/chat2ai',
    options: {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    },
  },
  jwt: {
    secret: process.env.JWT_SECRET || 'your-secret-key',
    expiresIn: process.env.JWT_EXPIRES_IN || '7d',
  },
  tracing: {
    enabled: process.env.TRACING_ENABLED === 'true',
    serviceName: 'chat2ai-backend',
    collectorUrl: process.env.TRACING_COLLECTOR_URL || 'http://localhost:4318',
  },
};