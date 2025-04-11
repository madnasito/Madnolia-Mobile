import 'dart:async' show StreamSubscription;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/enums/message_type.enum.dart';
import 'package:madnolia/models/chat/individual_message_model.dart';
import 'package:madnolia/models/chat/user_chat_model.dart';
import 'package:madnolia/models/chat/user_messages.body.dart';
import 'package:madnolia/models/chat_user_model.dart';
import 'package:madnolia/widgets/atoms/messages/atom_individual_message.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/molecules/chat/molecule_chat_input.dart';

class UserChatPage extends StatelessWidget {
  const UserChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    late UserChat userChat;
    if (GoRouterState.of(context).extra != null) {
      if (GoRouterState.of(context).extra is UserChat) {
        userChat = GoRouterState.of(context).extra as UserChat;
      }
    } else {
      context.go('/');
      return const SizedBox.shrink(); // Return empty widget while redirecting
    }

    return CustomScaffold(
      body: BlocProvider(
        create: (context) => MessageBloc()
          ..add(UserMessageFetched(messagesBody: UserMessagesBody(user: userChat.user.id, skip: 0))),
        child: Column(
          children: [
            MoleculeUserHeader(user: userChat.user),
            Expanded(child: OrganismChatMessages(id: userChat.id, user: userChat.user.id)),
            const SizedBox(height: 3),
            MoleculeChatInput(to: userChat.id, messageType: MessageType.user),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}


class MoleculeUserHeader extends StatelessWidget {

  final ChatUser user;
  const MoleculeUserHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      color: Colors.black45,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
                user.thumb),
            radius: 30,
          ),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name),
              Text("@${user.username}", style: TextStyle(fontSize: 12)),
            ],
          ),
          const Spacer(),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.call_outlined),
          // ),
          // IconButton(
          //   onPressed: () => _showCallOptions(context),
          //   icon: const Icon(CupertinoIcons.video_camera),
          // ),
        ],
      ),
    );
  }
}
class OrganismChatMessages extends StatefulWidget {
  final String id;
  final String user;
  const OrganismChatMessages({super.key, required this.id, required this.user});

  @override
  State<OrganismChatMessages> createState() => _OrganismChatMessagesState();
}

class _OrganismChatMessagesState extends State<OrganismChatMessages> {
  final _scrollController = ScrollController();
  late final MessageBloc _messageBloc;
  late final FlutterBackgroundService _backgroundService;
  late final UserBloc userBloc;
  int skip = 0;
  StreamSubscription? _messageSubscription;

  @override
  void initState() {
    super.initState();
    _messageBloc = context.read<MessageBloc>();
    _backgroundService = FlutterBackgroundService();
    userBloc = context.read<UserBloc>();
    _scrollController.addListener(_onScroll);

    _messageSubscription = _backgroundService.on("message").listen((onData) {
      if (mounted && onData != null) {
        _addMessage(onData);
      }
    });
  }

  void _addMessage(Map<String, dynamic> onData) {
    if (!mounted || onData['type'] != 0) return;

    try {
      final message = IndividualMessage.fromJson(onData);

      if (message.to == widget.id)  {
        _messageBloc.add(AddIndividualMessage(message: message));
      }
    } catch (e) {
      debugPrint('Error processing message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        if (state.status == MessageStatus.failure) {
          return const Center(child: Text("Failed fetching messages"));
        }

        // Show messages if we have any, regardless of loading status
        if (state.userMessages.isNotEmpty) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            color: Colors.black38,
            child: MoleculeChatMessagesList(
              state: state,
              scrollController: _scrollController,
              isLoading: state.status == MessageStatus.initial && !state.hasReachedMax,
            ),
          );
        }

        // Only show loading indicator if we have no messages at all
        if (state.status == MessageStatus.initial && !state.hasReachedMax) {
          return const Center(child: CircularProgressIndicator());
        }

        return const Center(child: Text('Say hi'));
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _messageBloc.add(RestoreState());
    _messageSubscription?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      skip += 10; // Increment skip for pagination
      _messageBloc.add(UserMessageFetched(
        messagesBody: UserMessagesBody(user: widget.id, skip: skip),
      ));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    return _scrollController.offset >=
        (_scrollController.position.maxScrollExtent * 0.9);
  }
}

class MoleculeChatMessagesList extends StatelessWidget {
  final MessageState state;
  final ScrollController scrollController;
  final bool isLoading;

  const MoleculeChatMessagesList({
    super.key,
    required this.state,
    required this.scrollController,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      addAutomaticKeepAlives: true,
      reverse: true,
      itemBuilder: (context, index) {
        if (index < state.userMessages.length) {
          return AtomIndividualMessage(message: state.userMessages[index]);
        }
        
        // Only show loading indicator at the bottom if we're loading more
        return isLoading
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              )
            : const SizedBox.shrink();
      },
      itemCount: state.userMessages.length + (isLoading ? 1 : 0),
      controller: scrollController,
    );
  }
}