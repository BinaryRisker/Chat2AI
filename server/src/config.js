require('dotenv').config();

module.exports = {
  env: process.env.NODE_ENV || 'development',
  port: process.env.PORT || 3000,
  db: {
    dialect: 'sqlite',
    storage: process.env.DB_STORAGE || './db.sqlite',
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