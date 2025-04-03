import 'dart:async' show StreamSubscription;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/enums/message_type.enum.dart';
import 'package:madnolia/models/chat/individual_message_model.dart';
import 'package:madnolia/models/chat/user_messages.body.dart';
import 'package:madnolia/models/chat_user_model.dart';
import 'package:madnolia/widgets/atoms/messages/atom_individual_message.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/molecules/chat/molecule_chat_input.dart';

class UserChatPage extends StatelessWidget {
  const UserChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    late ChatUser user;
    if (GoRouterState.of(context).extra != null) {
      if (GoRouterState.of(context).extra is ChatUser) {
        user = GoRouterState.of(context).extra as ChatUser;
      }
    } else {
      context.go('/');
      return const SizedBox.shrink(); // Return empty widget while redirecting
    }

    return CustomScaffold(
      body: BlocProvider(
        create: (context) => MessageBloc()
          ..add(UserMessageFetched(messagesBody: UserMessagesBody(user: user.id, skip: 0))),
        child: Column(
          children: [
            MoleculeUserHeader(user: user),
            Expanded(child: OrganismChatMessages(user: user.id)),
            const SizedBox(height: 3),
            MoleculeChatInput(to: user.id, messageType: MessageType.user),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
  

  Widget _buildChatHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      color: Colors.black45,
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
                "https://i.beeimg.com/images/thumb/z66297834451-xs.jpg"),
            radius: 30,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("NAME"),
              Text("@username", style: TextStyle(fontSize: 12)),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call_outlined),
          ),
          IconButton(
            onPressed: () => _showCallOptions(context),
            icon: const Icon(CupertinoIcons.video_camera),
          ),
        ],
      ),
    );
  }

  void _showCallOptions(BuildContext context) {
    showToastWidget(
      Container(
        padding: const EdgeInsets.all(20),
        color: Colors.black45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCallOptionButton(
              label: "Answer",
              icon: Icons.call,
              onPressed: () => ToastManager().dismissAll(),
            ),
            const SizedBox(width: 20),
            _buildCallOptionButton(
              label: "Refuse",
              icon: Icons.call_end_outlined,
              onPressed: () => ToastManager().dismissAll(),
            ),
          ],
        ),
      ),
      context: context,
      animation: StyledToastAnimation.slideFromTopFade,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.top,
      animDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 30),
      isIgnoring: false,
    );
  }

  Widget _buildCallOptionButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Text(label),
          const SizedBox(width: 5),
          Icon(icon, size: 20),
        ],
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
  final String user;
  const OrganismChatMessages({super.key, required this.user});

  @override
  State<OrganismChatMessages> createState() => _OrganismChatMessagesState();
}

class _OrganismChatMessagesState extends State<OrganismChatMessages> {
  final _scrollController = ScrollController();
  late final MessageBloc _messageBloc;
  late final FlutterBackgroundService _backgroundService;
  late final UserBloc _userBloc;
  int skip = 0;
  StreamSubscription? _messageSubscription;

  @override
  void initState() {
    super.initState();
    _messageBloc = context.read<MessageBloc>();
    _backgroundService = FlutterBackgroundService();
    _userBloc = context.read<UserBloc>();
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
      final currentUserId = _userBloc.state.id;

      if ((message.user == currentUserId && message.to == widget.user) ||
          (message.to == currentUserId && message.user == widget.user)) {
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

        return const Center(child: Text('No messages'));
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
        messagesBody: UserMessagesBody(user: widget.user, skip: skip),
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