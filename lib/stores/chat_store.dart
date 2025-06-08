import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat2ai/services/api_service.dart';

// --- Models (defined here due to file creation issues) ---
class Message {
  final String id;
  final String content;
  final bool isUser;
  Message({required this.id, required this.content, required this.isUser});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      content: json['content'],
      isUser: json['role'] == 'user',
    );
  }
}

class Conversation {
  final String id;
  final String title;
  final List<Message> messages;
  Conversation({required this.id, required this.title, this.messages = const []});

  factory Conversation.fromJson(Map<String, dynamic> json) {
    var messagesFromJson = json['messages'] as List? ?? [];
    List<Message> messageList = messagesFromJson.map((i) => Message.fromJson(i)).toList();
    return Conversation(
      id: json['id'],
      title: json['title'],
      messages: messageList,
    );
  }
}

// --- State ---
class ChatState {
  final List<Conversation> conversations;
  final String? activeConversationId;

  ChatState({this.conversations = const [], this.activeConversationId});

  ChatState copyWith({List<Conversation>? conversations, String? activeConversationId}) {
    return ChatState(
      conversations: conversations ?? this.conversations,
      activeConversationId: activeConversationId ?? this.activeConversationId,
    );
  }
}

// --- Notifier ---
class ChatNotifier extends AsyncNotifier<ChatState> {
  late ApiService _apiService;

  @override
  Future<ChatState> build() async {
    _apiService = ref.read(apiServiceProvider);
    final conversationsJson = await _apiService.getConversations();
    final conversations = conversationsJson.map((c) => Conversation.fromJson(c)).toList();
    return ChatState(conversations: conversations);
  }

  Future<void> createConversation(String title) async {
    final newConversationJson = await _apiService.createConversation(title);
    final newConversation = Conversation.fromJson(newConversationJson);
    state = AsyncData(state.value!.copyWith(
      conversations: [...state.value!.conversations, newConversation],
    ));
  }

  Future<void> sendMessage(String content) async {
    final conversationId = state.value!.activeConversationId;
    if (conversationId == null) return;
    
    // Optimistically add user's message
    final optimisticMessage = Message(id: 'temp', content: content, isUser: true);
    _updateConversationMessages(conversationId, optimisticMessage);

    // Get real response from server
    final responseJson = await _apiService.sendMessage(conversationId, content);
    final modelMessage = Message.fromJson(responseJson);

    // Replace optimistic message with server response
    _updateConversationMessages(conversationId, modelMessage, replaceLast: true);
  }

  void setActiveConversation(String conversationId) {
    state = AsyncData(state.value!.copyWith(activeConversationId: conversationId));
  }

  void _updateConversationMessages(String conversationId, Message message, {bool replaceLast = false}) {
    final newConversations = state.value!.conversations.map((c) {
      if (c.id == conversationId) {
        List<Message> newMessages = List.from(c.messages);
        if (replaceLast) {
          newMessages.removeLast();
        }
        newMessages.add(message);
        return Conversation(id: c.id, title: c.title, messages: newMessages);
      }
      return c;
    }).toList();
    state = AsyncData(state.value!.copyWith(conversations: newConversations));
  }
}

final chatNotifierProvider = AsyncNotifierProvider<ChatNotifier, ChatState>(() => ChatNotifier());