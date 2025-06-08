import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat2ai/stores/chat_store.dart';
import 'package:chat2ai/widgets/conversation_list.dart';
import 'package:chat2ai/pages/chat_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatStateAsync = ref.watch(chatNotifierProvider);

    return Scaffold(
      body: chatStateAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (chatState) {
          final activeConversationId = chatState.activeConversationId;
          return Row(
            children: [
              SizedBox(
                width: 300,
                child: ConversationList(
                  conversations: chatState.conversations,
                  onConversationSelected: (id) {
                    ref.read(chatNotifierProvider.notifier).setActiveConversation(id);
                  },
                ),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                child: activeConversationId != null
                    ? ChatPage(conversationId: activeConversationId)
                    : const Center(child: Text('Select a conversation to start')),
              ),
            ],
          );
        },
      ),
    );
  }
}