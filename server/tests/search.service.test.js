const chai = require('chai');
const sinon = require('sinon');
const SearchService = require('../services/search.service');
const Conversation = require('../models/conversation');
const Message = require('../models/message');

const { expect } = chai;

describe('SearchService', () => {
  let searchService;
  
  beforeEach(() => {
    searchService = new SearchService();
  });

  afterEach(() => {
    sinon.restore();
  });

  describe('searchConversations', () => {
    it('should search conversations by query', async () => {
      const userId = '123';
      const query = 'test';
      const expected = [{ title: 'Test Conversation' }];
      
      sinon.stub(Conversation, 'find').returns({
        sort: sinon.stub().resolves(expected)
      });
      
      const result = await searchService.searchConversations(userId, query);
      expect(result).to.deep.equal(expected);
      expect(Conversation.find.calledWith({
        userId,
        $text: { $search: query }
      }, {
        score: { $meta: 'textScore' }
      })).to.be.true;
    });
  });

  describe('searchMessages', () => {
    it('should search messages by query', async () => {
      const userId = '123';
      const query = 'test';
      const conversations = [{ _id: '1' }, { _id: '2' }];
      const expected = [{ content: 'Test Message' }];
      
      sinon.stub(Conversation, 'find').resolves(conversations);
      sinon.stub(Message, 'find').returns({
        sort: sinon.stub().resolves(expected)
      });
      
      const result = await searchService.searchMessages(userId, query);
      expect(result).to.deep.equal(expected);
      expect(Message.find.calledWith({
        conversationId: { $in: ['1', '2'] },
        $text: { $search: query }
      }, {
        score: { $meta: 'textScore' }
      })).to.be.true;
    });
  });

  describe('globalSearch', () => {
    it('should perform global search', async () => {
      const userId = '123';
      const query = 'test';
      const conversations = [{ title: 'Test Conversation' }];
      const messages = [{ content: 'Test Message' }];
      
      sinon.stub(searchService, 'searchConversations').resolves(conversations);
      sinon.stub(searchService, 'searchMessages').resolves(messages);
      
      const result = await searchService.globalSearch(userId, query);
      expect(result).to.deep.equal({
        conversations,
        messages
      });
    });
  });
});