import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:chat2ai/stores/chat_store.dart';
import 'package:chat2ai/widgets/chat_input.dart';
import 'package:chat2ai/widgets/message_bubble.dart';

class ChatPage extends ConsumerWidget {
  final String conversationId;

  const ChatPage({
    super.key,
    required this.conversationId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We only need to rebuild when the specific conversation changes.
    final conversation = ref.watch(chatNotifierProvider.select(
      (state) => state.value?.conversations.firstWhere((c) => c.id == conversationId),
    ));

    if (conversation == null) {
      return const Center(child: Text('Conversation not found.'));
    }

    final scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: Text(conversation.title),
        actions: [
          // This would be dynamic in a real app
          const Center(child: Text('GPT-4', style: TextStyle(color: Colors.white))),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              context.push('/settings');
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(8.0),
              itemCount: conversation.messages.length,
              itemBuilder: (context, index) {
                final message = conversation.messages[index];
                return MessageBubble(message: message);
              },
            ),
          ),
          ChatInput(
            onSend: (text) {
              ref.read(chatNotifierProvider.notifier).sendMessage(text);
            },
          ),
        ],
      ),
    );
  }
}