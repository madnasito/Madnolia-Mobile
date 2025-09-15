import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImageProvider;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/database/providers/friendship_db.dart';
import 'package:madnolia/database/providers/user_db.dart';
import 'package:madnolia/database/services/friendship-db.service.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';
import 'package:madnolia/models/chat/user_chat_model.dart';
import 'package:madnolia/models/chat_user_model.dart';
import 'package:madnolia/database/services/user-db.service.dart';


class AtomUserChat extends StatelessWidget {
  final UserChat userChat;
  
  const AtomUserChat({
    super.key, 
    required this.userChat,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FriendshipDb>(
      future: FriendshipService().getFriendship(userChat.id),
      builder: (BuildContext context, AsyncSnapshot<FriendshipDb> friendshipSnapshot) {
        // Manejo de estados del primer FutureBuilder
        if (friendshipSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (friendshipSnapshot.hasError) {
          return Center(
            child: Text(translate('CHAT.ERRORS.LOADING_CHAT', /* args: {'error': friendshipSnapshot.error}*/)
            )
          );
        }
        
        if (!friendshipSnapshot.hasData) {
          return Center(child: Text(translate('CHAT.ERRORS.NO_DATA')));
        }

        final friendship = friendshipSnapshot.data!;
        final userId = context.read<UserBloc>().state.id;
        final String notMe = friendship.user1 == userId ? friendship.user2 : friendship.user1;


        // Segundo FutureBuilder para obtener los datos del usuario
        return FutureBuilder<UserDb>(
          future: getUserDb(notMe),
          builder: (context, AsyncSnapshot<UserDb> snapshot) {
            // Manejo de estados del segundo FutureBuilder
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
            
            return Container(
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: ListTile(
                trailing: iReadThat(notMe) ? Icon(Icons.circle, color: Colors.yellow[400],) : null,
                onTap: () => context.pushNamed(
                  "user-chat", 
                  extra: ChatUser(
                    id: user.id,
                    name: user.name,
                    thumb: user.thumb,
                    username: user.username,
                  ),
                ),
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: CachedNetworkImageProvider(user.thumb),
                  backgroundColor: Colors.grey[800],
                ),
                title: Text(
                  user.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  userChat.message.text,
                  style: TextStyle(
                    color: iReadThat(notMe) ? Colors.white : Colors.grey[300],
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                tileColor: Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                dense: true,
              ),
            );
          },
        );
      },
    );
  }

  bool iReadThat(String notMyId) {
    return userChat.message.status == ChatListStatus.sent && userChat.message.creator == notMyId;
  }
}