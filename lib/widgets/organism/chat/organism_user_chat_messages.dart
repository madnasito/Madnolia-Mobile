import 'dart:async' show StreamSubscription;

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart' show FlutterBackgroundService;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/enums/chat_message_type.enum.dart';
import 'package:madnolia/enums/list_status.enum.dart' show ListStatus;
import 'package:madnolia/widgets/molecules/chat/molecule_user_chat_messages.dart' show MoleculeUserChatMessagesList;

class OrganismUserChatMessages extends StatefulWidget {
  final String id;
  final String user;
  const OrganismUserChatMessages({super.key, required this.id, required this.user});

  @override
  State<OrganismUserChatMessages> createState() => _OrganismUserChatMessagesState();
}

class _OrganismUserChatMessagesState extends State<OrganismUserChatMessages> {
  final _scrollController = ScrollController();
  late final MessageBloc _messageBloc;
  late final FlutterBackgroundService _backgroundService;
  late final UserBloc userBloc;
  StreamSubscription? _messageSubscription;

  @override
  void initState() {
    super.initState();
    _messageBloc = context.read<MessageBloc>();
    _backgroundService = FlutterBackgroundService();
    userBloc = context.read<UserBloc>();
    _scrollController.addListener(_onScroll);

    _backgroundService.invoke("join_room", {"room": widget.id});

    _messageSubscription = _backgroundService.on("message").listen((onData) {
      if (onData != null) {
        _addMessage(onData);
      }
    });

    _messageBloc.add(WatchRoomMessages(roomId: widget.id));

  }

  void _addMessage(Map<String, dynamic> onData) {
    if (!mounted || onData['type'] != 0) return;

    try {

      // final message = ChatMessage.fromJson(onData);

      // final messageData = ChatMessageRepository().createOrUpdate(message.toCompanion());

      // if (message.conversation == widget.id)  {
      //   _messageBloc.add(AddIndividualMessage(message: messageData));
      // }
    } catch (e) {
      debugPrint('Error processing message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {

        switch (state.status) {
          case ListStatus.failure:
              return Center(child: Text(translate("CHAT.ERRORS.LOADING")));
          case ListStatus.initial:
            return const Center(child: CircularProgressIndicator());
          case ListStatus.success:
            if (state.roomMessages.isNotEmpty) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                color: Colors.black38,
                child: MoleculeUserChatMessagesList(
                  state: state,
                  scrollController: _scrollController,
                  isLoading: state.status == ListStatus.initial && !state.hasReachedMax,
                ),
              );
            } else{
              return Center(child: Text(translate('CHAT.SAY_HI')));
            }
          // default:
          //   return Center(child: Text('Say hi'));
        }
        // if (state.status == ListStatus.failure) {
          
        // }
      },
    );
  }

  @override
  void dispose() {
    _backgroundService.invoke("leave_room");
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _messageBloc.add(RestoreState());
    _messageSubscription?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      _messageBloc.add(MessageFetched(roomId: widget.id, type: ChatMessageType.user)
      );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    return _scrollController.offset >=
        (_scrollController.position.maxScrollExtent * 0.9);
  }
}
