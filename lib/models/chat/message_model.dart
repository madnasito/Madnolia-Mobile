// To parse this JSON data, do
//
//     final chatMessage = chatMessageFromJson(jsonString);

import 'dart:convert';

import 'package:madnolia/enums/message-status.enum.dart';
import 'package:madnolia/enums/message_type.enum.dart';

class ChatMessage {
    String id;
    ChatMessageStatus status;
    String text;
    MessageType type;
    String conversation;
    String creator;
    DateTime date;

    ChatMessage({
        required this.id,
        required this.status,
        required this.text,
        required this.type,
        required this.conversation,
        required this.creator,
        required this.date,
    });

    factory ChatMessage.fromJson(Map<String, dynamic> json) {
      MessageType messageType;
      ChatMessageStatus messageStatus;
      
      switch (json["type"]) {
        case 0:
          messageType = MessageType.user;
          break;
        case 1:
          messageType = MessageType.group;
          break;
        case 2:
          messageType = MessageType.match;
          break;
        default:
          messageType = MessageType.user;
          break;
      }

      switch (json["status"]) {
        case 0:
          messageStatus = ChatMessageStatus.sent;
          break;
        case 1:
          messageStatus = ChatMessageStatus.delivered;
          break;
        case 2:
          messageStatus = ChatMessageStatus.read;
          break;
        case 3:
          messageStatus = ChatMessageStatus.deleted;
          break;
        default:
          messageStatus = ChatMessageStatus.sent;
          break;
      }
      
      return ChatMessage(
        id: json["id"],
        status: messageStatus,
        text: json["text"],
        type: messageType,
        conversation: json["conversation"],
        creator: json["creator"],
        date: DateTime.parse(json["date"]),
      );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status.index,  // Convert enum to its index
        "text": text,
        "type": type.index,      // Convert enum to its index
        "conversation": conversation,
        "creator": creator,
        "date": date.toIso8601String(),
    };
}

String chatMessageToJson(ChatMessage data) => json.encode(data.toJson());
ChatMessage chatMessageFromJson(String str) => ChatMessage.fromJson(json.decode(str));





// import 'dart:convert';
// import 'package:madnolia/enums/message_type.enum.dart';
// import 'package:equatable/equatable.dart';

// ChatMessage chatMessageFromJson(String str) => ChatMessage.fromJson(json.decode(str));

// String chatMessageToJson(ChatMessage data) => json.encode(data.toJson());

// class ChatMessage extends Equatable {
//   final String id;
//   final String to;
//   final String user;
//   final String text;
//   final DateTime date;
//   final MessageType type;

//   const ChatMessage({
//     required this.id,
//     required this.to,
//     required this.user,
//     required this.text,
//     required this.date,
//     required this.type,
//   });

//   factory ChatMessage.fromJson(Map<String, dynamic> json) {
//     MessageType messageType;
//     switch (json["type"]) {
//       case 0:
//         messageType = MessageType.user;
//         break;
//       case 1:
//         messageType = MessageType.group;
//         break;
//       case 2:
//         messageType = MessageType.match;
//         break;
//       default:
//         messageType = MessageType.user;
//         break;
//     }
//     return ChatMessage(
//       id: json["_id"],
//       to: json["to"],
//       user: json["user"],
//       text: json["text"],
//       date: DateTime.parse(json["date"]),
//       type: messageType,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "to": to,
//         "user": user,
//         "text": text,
//         "date": date.toIso8601String(),
//         "type": type.index,
//       };

//   @override
//   List<Object> get props => [id, to, user, text, date, type];
// }