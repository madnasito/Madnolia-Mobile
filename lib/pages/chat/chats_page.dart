import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/chat/user_chat_model.dart';
import 'package:madnolia/services/messages_service.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(body: OrganismUserChats());
  }
}

class OrganismUserChats extends StatelessWidget {
  const OrganismUserChats({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MessagesService().getChats(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
            padding: const EdgeInsets.all(0),
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) => AtomUserChat(userChat: snapshot.data[index])
            );
        }
        else if(snapshot.hasError){
          return Center(
            child: Text("Error loading chats"),
          );
        }
        else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}

class AtomUserChat extends StatelessWidget {

  final UserChat userChat;
  const AtomUserChat({super.key, required this.userChat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.goNamed("user_chat", extra: userChat.user.id),
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: CachedNetworkImageProvider(userChat.user.thumb),
      ),
      subtitle: Text(userChat.lastMessage.text),
      title: Text(userChat.user.name)
    );
  }
}