const app = require('./app');
const config = require('./config');
const { connectDB, disconnectDB } = require('./db');

const server = app.listen(config.port, async () => {
  try {
    await connectDB();
    console.log(`Server running on port ${config.port}`);
  } catch (err) {
    console.error('Failed to start server:', err);
    process.exit(1);
  }
});

// 优雅关闭
process.on('SIGTERM', () => {
  console.log('SIGTERM received. Shutting down gracefully');
  server.close(async () => {
    await disconnectDB();
    console.log('Process terminated');
    process.exit(0);
  });
});

process.on('SIGINT', () => {
  console.log('SIGINT received. Shutting down gracefully');
  server.close(async () => {
    await disconnectDB();
    console.log('Process terminated');
    process.exit(0);
  });
});