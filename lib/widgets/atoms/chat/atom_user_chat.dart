import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImageProvider;
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/database/repository_manager.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';
import 'package:madnolia/models/chat/user_chat.dart';
import 'package:madnolia/models/chat_user_model.dart';


class AtomUserChat extends StatelessWidget {
  final UserChat userChat;
  
  const AtomUserChat({
    super.key, 
    required this.userChat,
  });

  @override
  Widget build(BuildContext context) {
    final friendshipRepository = RepositoryManager().friendship;
    return FutureBuilder<FriendshipData>(
      future: friendshipRepository.getFriendshipById(userChat.message.conversation),
      builder: (BuildContext context, AsyncSnapshot<FriendshipData> friendshipSnapshot) {
        if (friendshipSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (friendshipSnapshot.hasError) {
          return Center(child: Text(translate('CHAT.ERRORS.LOADING_CHAT')));
        }
        
        if (!friendshipSnapshot.hasData) {
          return Center(child: Text(translate('CHAT.ERRORS.NO_DATA')));
        }

        final friendship = friendshipSnapshot.data!;
        final String notMe = friendship.user;

        final userRepository = RepositoryManager().user;
        return FutureBuilder<UserData>(
          future: userRepository.getUserById(notMe),
          builder: (context, AsyncSnapshot<UserData> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (snapshot.hasError) {
              return Center(child: Text(translate('CHAT.ERRORS.LOADING_USER')));
            }
            
            if (!snapshot.hasData) {
              return const Center(child: Text('CHAT.ERRORS.NO_USER_DATA'));
            }

            final user = snapshot.data!;
            
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
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0D1A26), Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFF00FFFF).withValues(alpha: 0.7), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00FFFF).withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF00FFFF),
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: CachedNetworkImageProvider(user.thumb),
                        backgroundColor: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontFamily: "Cyberverse",
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 3.0,
                                  color: Color(0xFF00FFFF),
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            userChat.message.content,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: iReadThat(notMe) ? Colors.white : Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (iReadThat(notMe))
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 255, 255, 122),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 255, 255, 122).withValues(alpha: 0.8),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  bool iReadThat(String notMyId) {
    return userChat.message.status == ChatMessageStatus.sent && userChat.message.creator == notMyId;
  }
}