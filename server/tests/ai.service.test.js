const { expect } = require('chai');
const sinon = require('sinon');
const axios = require('axios');
const OpenAIService = require('../services/ai/openai.service');
const ClaudeService = require('../services/ai/claude.service');

describe('AI Services', () => {
  describe('OpenAIService', () => {
    let openai;
    let axiosStub;

    beforeEach(() => {
      openai = new OpenAIService();
      axiosStub = sinon.stub(axios, 'post');
    });

    afterEach(() => {
      axiosStub.restore();
    });

    it('should make API call with correct parameters', async () => {
      const mockResponse = { data: { choices: [{ message: { content: 'Hello' } }] } };
      axiosStub.resolves(mockResponse);

      const params = {
        model: 'gpt-3.5-turbo',
        messages: [{ role: 'user', content: 'Hi' }],
        temperature: 0.7
      };

      const result = await openai.chatCompletion(params);
      expect(result).to.deep.equal(mockResponse.data);
      expect(axiosStub.calledOnce).to.be.true;
    });
  });

  describe('ClaudeService', () => {
    let claude;
    let axiosStub;

    beforeEach(() => {
      claude = new ClaudeService();
      axiosStub = sinon.stub(axios, 'post');
    });

    afterEach(() => {
      axiosStub.restore();
    });

    it('should make API call with correct parameters', async () => {
      const mockResponse = { data: { content: 'Hello' } };
      axiosStub.resolves(mockResponse);

      const params = {
        model: 'claude-3-sonnet',
        messages: [{ role: 'user', content: 'Hi' }],
        max_tokens: 100
      };

      const result = await claude.chatCompletion(params);
      expect(result).to.deep.equal(mockResponse.data);
      expect(axiosStub.calledOnce).to.be.true;
    });
  });
});