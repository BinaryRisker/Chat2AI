import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat2ai/stores/chat_store.dart';

class ConversationList extends ConsumerWidget {
  final List<Conversation> conversations;
  final Function(String) onConversationSelected;

  const ConversationList({
    super.key,
    required this.conversations,
    required this.onConversationSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'New Chat',
            onPressed: () {
              ref.read(chatNotifierProvider.notifier).createConversation('New Chat');
            },
          ),
        ],
        automaticallyImplyLeading: false, 
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conversation = conversations[index];
          return ListTile(
            leading: const Icon(Icons.chat_bubble_outline),
            title: Text(conversation.title),
            subtitle: Text(
              conversation.messages.isNotEmpty
                  ? conversation.messages.last.content
                  : 'No messages yet',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => onConversationSelected(conversation.id),
          );
        },
      ),
    );
  }
}