const axios = require('axios');
const config = require('../../config');

class OpenAIService {
  constructor() {
    this.client = axios.create({
      baseURL: 'https://api.openai.com/v1',
      headers: {
        'Authorization': `Bearer ${process.env.OPENAI_API_KEY}`,
        'Content-Type': 'application/json'
      }
    });
  }

  async chatCompletion(params) {
    try {
      const response = await this.client.post('/chat/completions', {
        model: params.model || 'gpt-3.5-turbo',
        messages: params.messages,
        temperature: params.temperature,
        top_p: params.top_p,
        max_tokens: params.max_tokens
      });
      return response.data;
    } catch (error) {
      console.error('OpenAI API Error:', error.response?.data || error.message);
      throw error;
    }
  }
}

module.exports = OpenAIService;