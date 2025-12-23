// import 'dart:math' as math;

// import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/chats/chats_bloc.dart';
import 'package:madnolia/enums/list_status.enum.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';
import 'package:madnolia/widgets/molecules/chat/molecule_users_chats.dart';

import '../../widgets/scaffolds/custom_scaffold.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: 
        Column(
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
      floatingActionButton: IconButton(
        onPressed: () => context.pushNamed('friendships'), 
        icon: Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withValues(alpha: 0.6),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: const Icon(
            Icons.person_add,
            color: Colors.white,
            size: 28,
          ),
        )
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

  @override
  void initState() {
    super.initState();
    _setupMessageListener();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setupMessageListener() {
    final chatsBloc = context.read<ChatsBloc>();

    // Initialize if needed
    if (chatsBloc.state.status == ListStatus.initial) {
      chatsBloc.add(UserChatsFetched());
      chatsBloc.add(WatchUserChats());
    }    
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsBloc, ChatsState>(
      builder: (context, state) {
        if (state.status == ListStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == ListStatus.success) {
         return (state.usersChats.isNotEmpty) 
          ? MoleculeUsersChats(usersChats: state.usersChats)
          : SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Center(child: Text(translate('CHAT.NO_MESSAGES'))
                    ),
          );
        } else if (state.status == ListStatus.failure && 
                  state.usersChats.isEmpty) {
          return SingleChildScrollView(
            
            physics: AlwaysScrollableScrollPhysics(),
            child: Center(child: Text(translate('CHAT.ERRORS.LOADING'))));
        } else {
          // Show existing chats even if there was a subsequent error
          return MoleculeUsersChats(usersChats: state.usersChats);
        }
      },
    );
  }
}