import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat2ai/stores/chat_store.dart';

class NewChatButton extends ConsumerWidget {
  const NewChatButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.add),
        label: const Text('New Chat'),
        onPressed: () {
          ref.read(chatStoreProvider.notifier).createConversation('New Chat');
        },
      ),
    );
  }
}