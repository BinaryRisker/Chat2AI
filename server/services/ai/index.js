const OpenAIService = require('./openai.service');
const ClaudeService = require('./claude.service');

class AIServiceFactory {
  static createService(provider) {
    switch (provider) {
      case 'openai':
        return new OpenAIService();
      case 'claude':
        return new ClaudeService();
      default:
        throw new Error(`Unsupported AI provider: ${provider}`);
    }
  }
}

module.exports = AIServiceFactory;