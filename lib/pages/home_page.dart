import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat2ai/stores/chat_store.dart';
import 'package:chat2ai/stores/user_store.dart';
import 'package:chat2ai/widgets/conversation_list.dart';
import 'package:chat2ai/widgets/new_chat_button.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatStoreProvider);
    final userState = ref.watch(userStoreProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat2AI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: chatState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ConversationList(conversations: chatState.conversations),
          ),
          const NewChatButton(),
        ],
      ),
    );
  }
}