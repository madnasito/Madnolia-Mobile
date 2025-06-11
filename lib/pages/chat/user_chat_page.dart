import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/enums/message_type.enum.dart';
import 'package:madnolia/models/chat/user_messages.body.dart';
import 'package:madnolia/models/chat_user_model.dart';
import 'package:madnolia/services/friendship_service.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/molecules/chat/molecule_chat_input.dart';
import 'package:madnolia/widgets/molecules/chat/molecule_user_header.dart' show MoleculeUserHeader;
import 'package:madnolia/widgets/organism/chat/organism_user_chat_messages.dart';

class UserChatPage extends StatelessWidget {
  const UserChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    late ChatUser chatUser;
    if (GoRouterState.of(context).extra != null) {
      if (GoRouterState.of(context).extra is ChatUser) {
        chatUser = GoRouterState.of(context).extra as ChatUser;

        return CustomScaffold(
          body: FutureBuilder(
            future: FriendshipService().getFriendwhipWithUser(chatUser.id),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return BlocProvider(
                  create: (context) => MessageBloc()
                    ..add(UserMessageFetched(messagesBody: UserMessagesBody(user: chatUser.id, skip: 0))),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => GoRouter.of(context).pushReplacement("/user/${chatUser.id}"),
                        child: MoleculeUserHeader(user: chatUser)),
                      Expanded(child: OrganismUserChatMessages(id: snapshot.data!.id, user: chatUser.id)),
                      const SizedBox(height: 3),
                      MoleculeChatInput(conversation: snapshot.data!.id, messageType: MessageType.user),
                      const SizedBox(height: 5),
                    ],
                  ),
                );
              } else if(snapshot.hasError) {
                return Center(child: Text("Error loading chat"));
              } else {
                return Center(child: CircularProgressIndicator());
              }
          },),
        );
      } else {
        // context.go('/');
        return const SizedBox.shrink(); // Return empty widget while redirecting  
      }
    } else {
      context.go('/');
      return const SizedBox.shrink(); // Return empty widget while redirecting
    }
  }
}

