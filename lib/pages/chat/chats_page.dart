import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/models/chat/user_chat_model.dart';
import 'package:madnolia/services/messages_service.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/molecules/chat/molecule_users_chats.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          CenterTitleAtom(text: translate("CHAT.MESSAGES")),
          const SizedBox(height: 10),
          Expanded(  // Use Expanded instead of Flexible here
            child: OrganismUserChats(),
          ),
        ],
      ),
    );
  }
}

class OrganismUserChats extends StatelessWidget {
  const OrganismUserChats({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MessagesService().getChats(),
      builder: (BuildContext context, AsyncSnapshot<List<UserChat>> snapshot) {
        if (snapshot.hasData) {
          return MoleculeUsersChats(usersChats: snapshot.data!);
        } else if (snapshot.hasError) {
          return Center(
            child: Text(translate("error.loading_chats")), // Consider using translation here
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}