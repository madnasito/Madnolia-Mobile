import 'dart:convert';

import '../../enums/chat_message_type.enum.dart';

// Extension to convert ChatMessageType to integer and vice versa
extension ChatMessageTypeExtension on ChatMessageType {
  int get value {
    switch (this) {
      case ChatMessageType.user:
        return 0;
      case ChatMessageType.group:
        return 1;
      case ChatMessageType.match:
        return 2;
      
    }
  }

  static ChatMessageType fromInt(int value) {
    switch (value) {
      case 0:
        return ChatMessageType.user;
      case 1:
        return ChatMessageType.group;
      case 2:
        return ChatMessageType.match;
      default:
        throw ArgumentError("Invalid ChatMessageType integer value: $value");
    }
  }
}

CreateMessage createMessageFromJson(String str) =>
    CreateMessage.fromJson(json.decode(str));

String createMessageToJson(CreateMessage data) => json.encode(data.toJson());

class CreateMessage {
  String id;
  String conversation;
  String content;
  ChatMessageType type; // Use the enum directly

  CreateMessage({
    required this.id,
    required this.conversation,
    required this.content,
    required this.type,
  });

  factory CreateMessage.fromJson(Map<String, dynamic> json) => CreateMessage(
    id: json["id"],
    conversation: json["conversation"],
    content: json["content"],
    type: ChatMessageTypeExtension.fromInt(json["type"]), // Convert int to enum
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "conversation": conversation,
    "content": content,
    "type": type.value, // Convert enum to int
  };
}