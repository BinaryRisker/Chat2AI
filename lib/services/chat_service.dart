import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chat2ai/models/chat_model.dart';
import 'api_service.dart';

class ChatService {
  final ApiService _apiService;

  ChatService(this._apiService);

  Future<List<Conversation>> getConversations() async {
    final response = await _apiService.get('/conversations');
    return (response.data as List)
        .map((e) => Conversation.fromJson(e))
        .toList();
  }

  Future<Conversation> createConversation(String title) async {
    final response = await _apiService.post(
      '/conversations',
      data: {'title': title},
    );
    return Conversation.fromJson(response.data);
  }

  Future<Conversation> getConversation(String id) async {
    final response = await _apiService.get('/conversations/\$id');
    return Conversation.fromJson(response.data);
  }

  Future<ChatMessage> sendMessage({
    required String conversationId,
    required String content,
    required String model,
    Map<String, dynamic>? parameters,
  }) async {
    final response = await _apiService.post(
      '/conversations/\$conversationId/messages',
      data: {
        'content': content,
        'model': model,
        'parameters': parameters,
      },
    );
    return ChatMessage.fromJson(response.data);
  }

  Future<void> deleteConversation(String id) async {
    await _apiService.delete('/conversations/\$id');
  }
}

final chatServiceProvider = Provider<ChatService>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return ChatService(apiService);
});