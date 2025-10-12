// import 'dart:convert';
// import 'package:madnolia/enums/message_type.enum.dart';

// IndividualMessage messageFromJson(String str) => IndividualMessage.fromJson(json.decode(str));

// String messageToJson(IndividualMessage data) => json.encode(data.toJson());

// class IndividualMessage {
//   String id;
//   String to;
//   String user;
//   String text;
//   DateTime date;
//   ChatMessageType type; // Use the enum directly

//   IndividualMessage({
//     required this.id,
//     required this.to,
//     required this.user,
//     required this.text,
//     required this.date,
//     required this.type,
//   });

//   factory IndividualMessage.fromJson(Map<String, dynamic> json) {
//     ChatMessageType messageType;
//     switch (json["type"]){
//       case 0:
//         messageType = ChatMessageType.user;
//         break;
//       case 1:
//         messageType = ChatMessageType.group;
//         break;
//       case 2:
//         messageType = ChatMessageType.match;
//         break;
//       default:
//         messageType = ChatMessageType.user;
//         break;
//     }
//     return IndividualMessage(
//         id: json["_id"],
//         to: json["to"],
//         user: json["user"],
//         text: json["text"],
//         date: DateTime.parse(json["date"]),
//         type: messageType, // Convert int to enum
//       );
//     }

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "to": to,
//         "user": user,
//         "text": text,
//         "date": date.toIso8601String(),
//         "type": type.index, // Convert enum to int
//       };
// }