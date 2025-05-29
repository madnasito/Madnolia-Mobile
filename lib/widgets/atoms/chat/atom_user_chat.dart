import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImageProvider;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/chat/user_chat_model.dart';
import 'package:madnolia/models/chat_user_model.dart';
import 'package:madnolia/utils/user_db_util.dart';

class AtomUserChat extends StatelessWidget {
  final UserChat userChat;
  
  const AtomUserChat({
    super.key, 
    required this.userChat,
  });

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: getUserDb(userChat.user),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.black45, // Darker background
              borderRadius: BorderRadius.circular(12), // Optional rounded corners
            ),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8), // Add some spacing
            child: ListTile(
              trailing: Icon(Icons.message_rounded),
              onTap: () => context.pushNamed(
                "user_chat", 
                extra: ChatUser(
                  id: snapshot.data!.id,
                  name: snapshot.data!.name,
                  thumb: snapshot.data!.thumb,
                  username: snapshot.data!.username)
                ,
              ),
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: CachedNetworkImageProvider(snapshot.data!.thumb),
                backgroundColor: Colors.grey[800], // Fallback color if image fails
              ),
              title: Text(
                snapshot.data!.name,
                style: TextStyle(
                  color: Colors.white, // White text for better contrast
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                userChat.lastMessage.text,
                style: TextStyle(
                  color: Colors.grey[300], // Lighter grey for subtitle
                  overflow: TextOverflow.ellipsis, // Handle long text
                ),
              ),
              tileColor: Colors.transparent, // Make ListTile transparent to show container color
              contentPadding: const EdgeInsets.symmetric(horizontal: 12), // Inner padding
              dense: true, // Makes the tile more compact
            ),
          );
        }else if(snapshot.hasError) {
          return Center(child: Text('Error loading this user'));
        } else{
          return CircularProgressIndicator.adaptive();
        }
      },
       
    );
  }
}