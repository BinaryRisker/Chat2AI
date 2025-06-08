const { Op } = require('sequelize');
const SearchService = require('../src/services/search.service');
const { Conversation, Message } = require('../src/models');

jest.mock('../src/models', () => ({
  Conversation: {
    findAll: jest.fn(),
  },
  Message: {
    findAll: jest.fn(),
  },
}));

describe('SearchService', () => {
  afterEach(() => {
    jest.clearAllMocks();
  });

  describe('searchConversations', () => {
    it('should search conversations by query', async () => {
      const req = { user: { id: 1 }, query: { q: 'Test' } };
      const expected = [{ title: 'Test Conversation' }];
      
      Conversation.findAll.mockResolvedValue(expected);
      
      const result = await SearchService.searchConversations(req);
      
      expect(result).toEqual(expected);
      expect(Conversation.findAll).toHaveBeenCalledWith({
        where: {
          userId: 1,
          title: { [Op.like]: '%Test%' }
        }
      });
    });
  });

  describe('searchMessages', () => {
    it('should search messages by query', async () => {
      const req = { user: { id: 1 }, query: { q: 'Test' } };
      const expected = [{ content: 'Test Message' }];
      
      Message.findAll.mockResolvedValue(expected);

      const result = await SearchService.searchMessages(req);
      
      expect(result).toEqual(expected);
      expect(Message.findAll).toHaveBeenCalledWith({
        where: {
          content: { [Op.like]: '%Test%' }
        },
        include: [{
          model: Conversation,
          where: { userId: 1 },
          attributes: []
        }]
      });
    });
  });
}); 