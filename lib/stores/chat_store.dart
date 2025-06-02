import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Message {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;

  Message({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
  });
}

class ChatState {
  final List<Message> messages;
  final bool isLoading;

  const ChatState({
    required this.messages,
    required this.isLoading,
  });

  ChatState copyWith({
    List<Message>? messages,
    bool? isLoading,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ChatStore extends StateNotifier<ChatState> {
  ChatStore()
      : super(
          const ChatState(
            messages: [],
            isLoading: false,
          ),
        );

  void addMessage(Message message) {
    state = state.copyWith(
      messages: [...state.messages, message],
    );
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void clearChat() {
    state = state.copyWith(messages: []);
  }
}

final chatStoreProvider = StateNotifierProvider<ChatStore, ChatState>(
  (ref) => ChatStore(),
);