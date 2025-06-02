import 'package:flutter/material.dart';
import 'package:chat2ai/models/chat_model.dart';

class ConversationList extends StatelessWidget {
  final List<Conversation> conversations;

  const ConversationList({
    super.key,
    required this.conversations,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conversation = conversations[index];
        return ListTile(
          leading: const Icon(Icons.chat),
          title: Text(conversation.title),
          subtitle: Text(
            conversation.messages.isNotEmpty
                ? conversation.messages.last.content
                : 'No messages yet',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/chat/\${conversation.id}',
            );
          },
        );
      },
    );
  }
}