import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat2ai/models/chat_model.dart';
import 'package:chat2ai/stores/chat_store.dart';
import 'package:chat2ai/widgets/chat_input.dart';
import 'package:chat2ai/widgets/message_bubble.dart';

class ChatPage extends ConsumerStatefulWidget {
  final String conversationId;

  const ChatPage({
    super.key,
    required this.conversationId,
  });

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadConversation();
  }

  Future<void> _loadConversation() async {
    await ref
        .read(chatStoreProvider.notifier)
        .loadConversation(widget.conversationId);
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatStoreProvider);
    final conversation = chatState.currentConversation;

    return Scaffold(
      appBar: AppBar(
        title: Text(conversation?.title ?? 'New Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              itemCount: conversation?.messages.length ?? 0,
              itemBuilder: (context, index) {
                final message = conversation!.messages[index];
                return MessageBubble(message: message);
              },
            ),
          ),
          ChatInput(
            onSend: (message) async {
              await ref
                  .read(chatStoreProvider.notifier)
                  .sendMessage(
                    conversationId: widget.conversationId,
                    content: message,
                  );
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}