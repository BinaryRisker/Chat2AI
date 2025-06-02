const mongoose = require('mongoose');
const config = require('./config');

let connection;

async function connectDB() {
  if (connection) return connection;

  try {
    connection = await mongoose.connect(config.db.uri, config.db.options);
    console.log('MongoDB connected');
    return connection;
  } catch (err) {
    console.error('MongoDB connection error:', err);
    throw err;
  }
}

async function disconnectDB() {
  if (!connection) return;

  try {
    await mongoose.disconnect();
    console.log('MongoDB disconnected');
    connection = null;
  } catch (err) {
    console.error('MongoDB disconnection error:', err);
    throw err;
  }
}

module.exports = { connectDB, disconnectDB };