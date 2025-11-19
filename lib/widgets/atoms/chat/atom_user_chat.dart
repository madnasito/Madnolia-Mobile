import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImageProvider;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';
import 'package:madnolia/models/chat/user_chat.dart';
import 'package:madnolia/models/chat_user_model.dart';

class AtomUserChat extends StatelessWidget {
  final UserChat userChat;
  const AtomUserChat({super.key, required this.userChat});

  @override
  Widget build(BuildContext context) {
    String notMe = userChat.user.id; // Store notMe after fetching friendship
    final user = userChat.user;
    final isNotMyMessage = userChat.message.creator == notMe;
    final isUnreadStatus = userChat.message.status == ChatMessageStatus.sent || userChat.message.status == ChatMessageStatus.delivered;
    final hasUnread = isNotMyMessage && isUnreadStatus;

    // --- Redesigned Decorations for a more subtle, futuristic look ---

    // A subtle glow for unread messages, less 'scandalous'
    final unreadBoxDecoration = BoxDecoration(
      color: Colors.black.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: const Color(0xFF00FFFF).withValues(alpha: 0.3), width: 1),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF00FFFF).withValues(alpha:  0.15),
          blurRadius: 8,
          spreadRadius: -2,
        ),
        BoxShadow(
          color: const Color(0xFF000000).withValues(alpha: 0.5),
          blurRadius: 5,
          spreadRadius: -3,
        ),
      ],
    );

    final readBoxDecoration = BoxDecoration(
      color: Colors.black.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.grey[800]!.withValues(alpha: 0.5), width: 1),
    );

    // Subtle glow for the avatar
    final unreadAvatarDecoration = BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: const Color(0xFF00FFFF).withValues(alpha: 0.5), width: 1),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF00FFFF).withValues(alpha:  0.2),
          blurRadius: 4,
        )
      ]
    );

    final readAvatarDecoration = BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey[800]!, width: 1),
    );
    
    return GestureDetector(
      onTap: () => context.pushNamed(
        "user-chat", 
        extra: ChatUser(
          id: user.id,
          name: user.name,
          thumb: user.thumb,
          username: user.username,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        padding: const EdgeInsets.all(10),
        decoration: hasUnread ? unreadBoxDecoration : readBoxDecoration,
        child: Row(
          children: [
            Container(
              decoration: hasUnread ? unreadAvatarDecoration : readAvatarDecoration,
              child: CircleAvatar(
                radius: 22,
                backgroundImage: CachedNetworkImageProvider(user.thumb),
                backgroundColor: Colors.grey[800],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (hasUnread)
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF00FFFF),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF00FFFF).withValues(alpha: 0.6),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      Text(
                        user.name,
                        style: TextStyle(
                          fontFamily: "Cyberverse",
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          shadows: hasUnread ? [
                            Shadow(
                              blurRadius: 5.0,
                              color: const Color(0xFF00FFFF).withValues(alpha: 0.5),
                              offset: const Offset(0, 0),
                            ),
                          ] : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: EdgeInsets.only(left: hasUnread ? 14 : 0),
                    child: Text(
                      userChat.message.content,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: hasUnread ? Colors.white : Colors.grey[400],
                        fontSize: 14,
                        fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _BuildTimestampAndStatus(
              chat: userChat,
              notMyId: notMe,
            ),
          ],
        ),
      ),
    );
  }
}


class _BuildTimestampAndStatus extends StatelessWidget {
  final UserChat chat;
  final String notMyId;
  const _BuildTimestampAndStatus({required this.chat, required this.notMyId});

  @override
  Widget build(BuildContext context) {
    final message = chat.message;
    final isMyMessage = message.creator != notMyId;

    // --- Date Formatting ---
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(message.date.year, message.date.month, message.date.day);
    
    String formattedDate;
    if (messageDate == today) {
      formattedDate = DateFormat.jm().format(message.date); // HH:mm
    } else {
      formattedDate = DateFormat('dd/MM').format(message.date); // dd/MM
    }

    // --- Status Icon ---
    Widget statusWidget;
    if (isMyMessage) {
      IconData statusIcon;
      Color statusColor = Colors.grey[400]!;

      switch (message.status) {
        case ChatMessageStatus.sent:
          statusIcon = Icons.check;
          break;
        case ChatMessageStatus.delivered:
          statusIcon = Icons.done_all;
          break;
        case ChatMessageStatus.read:
          statusIcon = Icons.done_all;
          statusColor = const Color(0xFF00FFFF); // Neon color for read
          break;
        default:
          statusIcon = Icons.access_time; // For pending or other states
      }
      statusWidget = Icon(statusIcon, size: 16, color: statusColor);
    } else {
      statusWidget = const SizedBox(height: 16); // Reserve space but show nothing
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          formattedDate,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 5),
        statusWidget,
      ],
    );
  }
}