const OpenAIService = require('../src/services/ai/openai.service');
const ClaudeService = require('../src/services/ai/claude.service');
const axios = require('axios');

jest.mock('axios');

describe('OpenAIService', () => {
  let postMock;

  beforeEach(() => {
    postMock = jest.fn();
    axios.create.mockReturnValue({ post: postMock });
  });

  afterEach(() => {
    jest.resetAllMocks();
  });

  it('should make API call with correct parameters', async () => {
    const openai = new OpenAIService();
    const mockResponse = { data: { choices: [{ message: { content: 'Hello' } }] } };
    postMock.mockResolvedValue(mockResponse);

    const params = {
      model: 'gpt-3.5-turbo',
      messages: [{ role: 'user', content: 'Hi' }],
      temperature: 0.7
    };

    const result = await openai.chatCompletion(params);
    expect(result).toEqual(mockResponse.data);
    expect(axios.create).toHaveBeenCalledTimes(1);
    expect(postMock).toHaveBeenCalledTimes(1);
    expect(postMock).toHaveBeenCalledWith('/chat/completions', expect.any(Object));
  });
});

describe('ClaudeService', () => {
  let postMock;

  beforeEach(() => {
    postMock = jest.fn();
    axios.create.mockReturnValue({ post: postMock });
  });

  afterEach(() => {
    jest.resetAllMocks();
  });

  it('should make API call with correct parameters', async () => {
    const claude = new ClaudeService();
    const mockResponse = { data: { content: [{ type: 'text', text: 'Hello from Claude' }] } };
    postMock.mockResolvedValue(mockResponse);
    
    const params = {
      model: 'claude-3-sonnet',
      messages: [{ role: 'user', content: 'Hi' }],
      max_tokens: 100
    };

    const result = await claude.chatCompletion(params);
    expect(result).toEqual(mockResponse.data);
    expect(axios.create).toHaveBeenCalledTimes(1);
    expect(postMock).toHaveBeenCalledTimes(1);
    expect(postMock).toHaveBeenCalledWith('/messages', expect.any(Object));
  });
});