import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat2ai/stores/chat_store.dart';
import 'package:go_router/go_router.dart';

class NewChatButton extends ConsumerWidget {
  const NewChatButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        // This logic would need to be adapted.
        // For now, we'll just navigate to a new chat page.
        final newId = DateTime.now().millisecondsSinceEpoch.toString();
        context.go('/chat/$newId');
        // ref.read(chatNotifierProvider.notifier).createConversation('New Chat');
      },
    );
  }
}