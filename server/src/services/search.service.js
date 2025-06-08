const { Op } = require('sequelize');
const { Conversation, Message } = require('../models');

class SearchService {
  async searchConversations(req) {
    const { q: query } = req.query;
    const userId = req.user.id;
    try {
      return await Conversation.findAll({
        where: {
          userId,
          title: {
            [Op.like]: `%${query}%`
          }
        }
      });
    } catch (error) {
      console.error('Search conversations error:', error);
      throw error;
    }
  }

  async searchMessages(req) {
    const { q: query } = req.query;
    const userId = req.user.id;
    try {
      return await Message.findAll({
        where: {
          content: {
            [Op.like]: `%${query}%`
          }
        },
        include: [{
          model: Conversation,
          where: { userId },
          attributes: []
        }]
      });
    } catch (error) {
      console.error('Search messages error:', error);
      throw error;
    }
  }

  async globalSearch(req) {
    try {
      const [conversations, messages] = await Promise.all([
        this.searchConversations(req),
        this.searchMessages(req)
      ]);

      return {
        conversations,
        messages
      };
    } catch (error) {
      console.error('Global search error:', error);
      throw error;
    }
  }
}

module.exports = new SearchService();