const { Conversation } = require('../models');
// SearchService needs to be refactored or removed as it depends on old models.
// For now, we will implement the logic directly.

const getConversations = async (req, res) => {
  try {
    const conversations = await Conversation.findAll({
      where: { userId: req.user.id },
      order: [['updatedAt', 'DESC']],
    });
    res.json(conversations);
  } catch (err) {
    console.error('Get conversations error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const createConversation = async (req, res) => {
  try {
    const conversation = await Conversation.create({
      userId: req.user.id,
      title: req.body.title || 'New Conversation'
    });
    res.status(201).json(conversation);
  } catch (err) {
    console.error('Create conversation error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
};

const searchConversations = async (req, res) => {
  // Full-text search in SQLite is more complex than with MongoDB's $text index.
  // It requires using MATCH which is often enabled via a FTS extension (FTS3/4/5).
  // For simplicity, we will use a simple LIKE query here.
  // For a production app, enabling FTS5 would be the recommended approach.
  const { Op } = require('sequelize');

  try {
    const { q } = req.query;
    if (!q) {
      return res.status(400).json({ error: 'Query parameter q is required' });
    }

    const results = await Conversation.findAll({
      where: {
        userId: req.user.id,
        title: {
          [Op.like]: `%${q}%`,
        },
      },
    });
    res.json(results);
  } catch (err) {
    console.error('Search error:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
};

module.exports = {
  getConversations,
  createConversation,
  searchConversations,
}; 