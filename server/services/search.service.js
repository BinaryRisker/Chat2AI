const Conversation = require('../models/conversation');
const Message = require('../models/message');

class SearchService {
  async searchConversations(userId, query) {
    try {
      return await Conversation.find(
        {
          userId,
          $text: { $search: query }
        },
        {
          score: { $meta: 'textScore' }
        }
      ).sort({ score: { $meta: 'textScore' } });
    } catch (error) {
      console.error('Search conversations error:', error);
      throw error;
    }
  }

  async searchMessages(userId, query) {
    try {
      // 先找到用户的所有会话
      const conversations = await Conversation.find({ userId });
      const conversationIds = conversations.map(c => c._id);

      return await Message.find(
        {
          conversationId: { $in: conversationIds },
          $text: { $search: query }
        },
        {
          score: { $meta: 'textScore' }
        }
      ).sort({ score: { $meta: 'textScore' } });
    } catch (error) {
      console.error('Search messages error:', error);
      throw error;
    }
  }

  async globalSearch(userId, query) {
    try {
      const [conversations, messages] = await Promise.all([
        this.searchConversations(userId, query),
        this.searchMessages(userId, query)
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

module.exports = SearchService;