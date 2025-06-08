const ChatService = require('../src/services/chat.service');
const AIServiceFactory = require('../src/services/ai');

jest.mock('../src/services/ai');

describe('ChatService', () => {
  let chatService;

  beforeEach(() => {
    chatService = new ChatService();
    jest.clearAllMocks();
  });

  it('should handle OpenAI response successfully', async () => {
    const mockService = {
      chatCompletion: jest.fn().mockResolvedValue({ choices: [{ message: { content: 'Hello from OpenAI' } }] })
    };
    AIServiceFactory.createService.mockReturnValue(mockService);

    const result = await chatService.getAIResponse('openai', {
      messages: [{ role: 'user', content: 'Hi' }]
    });

    expect(result.success).toBe(true);
    expect(result.data.choices[0].message.content).toBe('Hello from OpenAI');
    expect(AIServiceFactory.createService).toHaveBeenCalledWith('openai');
    expect(mockService.chatCompletion).toHaveBeenCalledTimes(1);
  });

  it('should handle Claude response successfully', async () => {
    const mockService = {
      chatCompletion: jest.fn().mockResolvedValue({ content: 'Hello from Claude' })
    };
    AIServiceFactory.createService.mockReturnValue(mockService);

    const result = await chatService.getAIResponse('claude', {
      messages: [{ role: 'user', content: 'Hi' }]
    });

    expect(result.success).toBe(true);
    expect(result.data.content).toBe('Hello from Claude');
    expect(AIServiceFactory.createService).toHaveBeenCalledWith('claude');
    expect(mockService.chatCompletion).toHaveBeenCalledTimes(1);
  });

  it('should handle API errors', async () => {
    const mockService = {
      chatCompletion: jest.fn().mockRejectedValue(new Error('API Error'))
    };
    AIServiceFactory.createService.mockReturnValue(mockService);

    const result = await chatService.getAIResponse('openai', {
      messages: [{ role: 'user', content: 'Hi' }]
    });

    expect(result.success).toBe(false);
    expect(result.error).toBe('API Error');
  });
});