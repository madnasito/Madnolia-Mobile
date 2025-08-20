import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/models/chat/user_chat_model.dart';
import 'package:madnolia/widgets/atoms/chat/atom_user_chat.dart' show AtomUserChat;

class MoleculeUsersChats extends StatelessWidget {
  final List<UserChat> usersChats;
  const MoleculeUsersChats({super.key, required this.usersChats});

  @override
  Widget build(BuildContext context) {
    final messageBloc = context.read<MessageBloc>();

    messageBloc.add(UpdateUnreadUserChatCount(value: -messageBloc.state.unreadUserChats));
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: usersChats.length,
      itemBuilder: (BuildContext context, int index) => 
        AtomUserChat(userChat: usersChats[index]),
    );
  }
}