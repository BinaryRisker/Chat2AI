const AIServiceFactory = require('./ai');

class ChatService {
  constructor() {
    this.aiServices = {};
  }

  async getAIResponse(provider, params) {
    if (!this.aiServices[provider]) {
      this.aiServices[provider] = AIServiceFactory.createService(provider);
    }
    
    try {
      const response = await this.aiServices[provider].chatCompletion(params);
      return {
        success: true,
        data: response
      };
    } catch (error) {
      return {
        success: false,
        error: error.message
      };
    }
  }
}

module.exports = ChatService;