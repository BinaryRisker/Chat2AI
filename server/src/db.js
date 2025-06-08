const { Sequelize } = require('sequelize');
const config = require('./config');
const betterSqlite3 = require('better-sqlite3');

const sequelize = new Sequelize({
  dialect: config.db.dialect,
  storage: config.db.storage,
  logging: console.log, // Enable logging to see SQL queries
  dialectModule: betterSqlite3,
});

async function connectDB() {
  try {
    await sequelize.authenticate();
    console.log('SQLite connection has been established successfully.');
    
    // Sync all defined models to the DB.
    // Use { force: true } to drop and re-create tables on every app start. (Useful for development)
    // Use { alter: true } to attempt to alter existing tables to match the model. (Be cautious in production)
    await sequelize.sync({ alter: true }); 
    console.log('All models were synchronized successfully.');

  } catch (err) {
    console.error('Unable to connect to the database:', err);
    throw err;
  }
}

async function disconnectDB() {
  try {
    await sequelize.close();
    console.log('SQLite connection has been closed.');
  } catch (err) {
    console.error('Error closing the database connection:', err);
    throw err;
  }
}

module.exports = { sequelize, connectDB, disconnectDB };