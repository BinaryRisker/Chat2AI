const axios = require('axios');
const config = require('../../config');

class ClaudeService {
  constructor() {
    this.client = axios.create({
      baseURL: 'https://api.anthropic.com/v1',
      headers: {
        'x-api-key': process.env.CLAUDE_API_KEY,
        'Content-Type': 'application/json',
        'anthropic-version': '2023-06-01'
      }
    });
  }

  async chatCompletion(params) {
    try {
      const response = await this.client.post('/messages', {
        model: params.model || 'claude-3-sonnet-20240229',
        messages: params.messages,
        max_tokens: params.max_tokens || 1024,
        temperature: params.temperature,
        top_p: params.top_p
      });
      return response.data;
    } catch (error) {
      console.error('Claude API Error:', error.response?.data || error.message);
      throw error;
    }
  }
}

module.exports = ClaudeService;