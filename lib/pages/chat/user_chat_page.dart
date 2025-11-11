import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/database/repository_manager.dart';
import 'package:madnolia/enums/chat_message_type.enum.dart';
import 'package:madnolia/models/chat_user_model.dart';
import 'package:madnolia/widgets/scaffolds/custom_scaffold.dart';
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
            future: RepositoryManager().friendship.getFriendshipByUserId(chatUser.id),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return BlocProvider(
                  create: (context) => MessageBloc()
                    ..add(MessageFetched(roomId: snapshot.data!.id, type: ChatMessageType.user)),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => GoRouter.of(context).push("/user/${chatUser.id}"),
                        child: MoleculeUserHeader(user: chatUser)),
                      Expanded(child: OrganismUserChatMessages(id: snapshot.data!.id, user: chatUser.id)),
                      const SizedBox(height: 3),
                      MoleculeChatInput(conversation: snapshot.data!.id, messageType: ChatMessageType.user),
                      const SizedBox(height: 5),
                    ],
                  ),
                );
              } else if(snapshot.hasError) {
                return Center(child: Text(translate('CHAT.ERRORS.LOADING_CHAT')));
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

