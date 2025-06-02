const { expect } = require('chai');
const sinon = require('sinon');
const ChatService = require('../services/chat.service');
const AIServiceFactory = require('../services/ai');

describe('ChatService', () => {
  let chatService;
  let openaiStub;
  let claudeStub;

  beforeEach(() => {
    chatService = new ChatService();
    openaiStub = sinon.stub(AIServiceFactory, 'createService').returns({
      chatCompletion: sinon.stub().resolves({ choices: [{ message: { content: 'Hello from OpenAI' } }] })
    });
    
    claudeStub = sinon.stub(AIServiceFactory, 'createService').returns({
      chatCompletion: sinon.stub().resolves({ content: 'Hello from Claude' })
    });
  });

  afterEach(() => {
    openaiStub.restore();
    claudeStub.restore();
  });

  it('should handle OpenAI response successfully', async () => {
    const result = await chatService.getAIResponse('openai', {
      messages: [{ role: 'user', content: 'Hi' }]
    });

    expect(result.success).to.be.true;
    expect(result.data.choices[0].message.content).to.equal('Hello from OpenAI');
  });

  it('should handle Claude response successfully', async () => {
    const result = await chatService.getAIResponse('claude', {
      messages: [{ role: 'user', content: 'Hi' }]
    });

    expect(result.success).to.be.true;
    expect(result.data.content).to.equal('Hello from Claude');
  });

  it('should handle API errors', async () => {
    const errorStub = sinon.stub(AIServiceFactory, 'createService').returns({
      chatCompletion: sinon.stub().rejects(new Error('API Error'))
    });

    const result = await chatService.getAIResponse('openai', {
      messages: [{ role: 'user', content: 'Hi' }]
    });

    expect(result.success).to.be.false;
    expect(result.error).to.equal('API Error');
    errorStub.restore();
  });
});