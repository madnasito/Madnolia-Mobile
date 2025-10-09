
import 'package:madnolia/models/chat/chat_message_model.dart';

class MessagesPage {
  final List<ChatMessage> messages;
  final String? nextCursor;

  MessagesPage({
    required this.messages,
    this.nextCursor,
  });

  factory MessagesPage.fromJson(Map<String, dynamic> json) {
    final messages = (json['messages'] as List)
        .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
        .toList();
        
    return MessagesPage(
      messages: messages,
      nextCursor: json['nextCursor'] as String?,
    );
  }
}
