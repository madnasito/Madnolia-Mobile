import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/blocs/chats/chats_bloc.dart';
import 'package:madnolia/enums/list_status.enum.dart';
import 'package:madnolia/enums/message_type.enum.dart';
import 'package:madnolia/models/chat/message_model.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';
import 'package:madnolia/widgets/molecules/chat/molecule_users_chats.dart';

import '../../widgets/custom_scaffold.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          CenterTitleAtom(
            text: translate("CHAT.MESSAGES"), 
            textStyle: neonTitleText,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _ChatListWithUpdates(),
          ),
        ],
      ),
    );
  }
}

class _ChatListWithUpdates extends StatefulWidget {
  const _ChatListWithUpdates();

  @override
  __ChatListWithUpdatesState createState() => __ChatListWithUpdatesState();
}

class __ChatListWithUpdatesState extends State<_ChatListWithUpdates> {
  StreamSubscription? _messageSubscription;

  @override
  void initState() {
    super.initState();
    _setupMessageListener();
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    super.dispose();
  }

  void _setupMessageListener() {
    final service = FlutterBackgroundService();
    final chatsBloc = context.read<ChatsBloc>();

    // Initialize if needed
    if (chatsBloc.state.status == ListStatus.initial) {
      chatsBloc.add(UserChatsFetched());
    }

    // Listen for new messages
    _messageSubscription = service.on('message').listen((onData) {
      if (onData != null) {
        final message = ChatMessage.fromJson(onData);
        if (message.type == MessageType.user) {
          chatsBloc.add(AddIndividualMessage(message: message));
          setState(() {
            
          });
        }
      }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsBloc, ChatsState>(
      builder: (context, state) {
        if (state.status == ListStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == ListStatus.success) {
          return MoleculeUsersChats(usersChats: state.usersChats);
        } else if (state.status == ListStatus.failure && 
                  state.usersChats.isEmpty) {
          return Center(child: Text(translate('CHAT.LOADING_ERROR')));
        } else {
          // Show existing chats even if there was a subsequent error
          return MoleculeUsersChats(usersChats: state.usersChats);
        }
      },
    );
  }
}