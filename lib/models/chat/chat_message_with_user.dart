import 'package:madnolia/database/database.dart';

class ChatMessageWithUser {
  final ChatMessageData chatMessage;
  final UserData user;

  const ChatMessageWithUser({ required this.chatMessage, required this.user});
}