import 'dart:async' show StreamSubscription;

import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/blocs/message/message_bloc.dart';
import 'package:madnolia/blocs/message_provider.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';
import 'package:madnolia/models/chat/message_model.dart';
import 'package:madnolia/models/chat_user_model.dart';
import 'package:madnolia/widgets/chat/input_widget.dart';
import 'package:madnolia/widgets/form_button.dart';
import 'package:madnolia/widgets/organism/chat_message_organism.dart';
import 'package:madnolia/widgets/organism/organism_match_info.dart';

import '../../models/match/full_match.model.dart';

class ViewMatch extends StatefulWidget {
  final FullMatch match;
  const ViewMatch({super.key, required this.match});

  @override
  State<ViewMatch> createState() => _ViewMatchState();
}

class _ViewMatchState extends State<ViewMatch> {
  bool isInMatch = false;
  bool socketConnected = true;
  late UserBloc userBloc;
  late final FlutterBackgroundService backgroundService;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();
    backgroundService = FlutterBackgroundService();
    _initializeServices();
  }

  void _initializeServices() {
    backgroundService.invoke("init");
    backgroundService.on("new_player_to_match").listen((data) {
      ChatUser user = ChatUser.fromJson(data!);
      debugPrint(user.name);
    });
    backgroundService.on("added_to_match").listen((data) {
      if (data?["resp"] == true) {
        isInMatch = true;
        if (mounted) setState(() {});
      }
    });
    backgroundService.invoke("init_chat", {"room": widget.match.id});
    backgroundService.on("disconnected_socket").listen((_) => setState(() => socketConnected = false));
    backgroundService.on("connected_socket").listen((_) => setState(() => socketConnected = true));
    userBloc.updateChatRoom(widget.match.id);
  }

  @override
  void dispose() {
    backgroundService.invoke("disconnect_chat");
    backgroundService.invoke("off_new_player_to_match");
    userBloc.updateChatRoom("");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMatchHeader(),
        Expanded(child: MoleculeRoomMessages(room: widget.match.id)),
        _buildBottomRow(context),
      ],
    );
  }

  Widget _buildMatchHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.match.title, style: const TextStyle(fontSize: 20)),
            Text(widget.match.game.name, style: const TextStyle(fontSize: 12)),
          ],
        ),
        Row(
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: widget.match.game.background != null
                  ? CachedNetworkImage(
                      imageUrl: widget.match.game.background!,
                      width: 80,
                      fit: BoxFit.cover,
                    )
                  : Image.asset("assets/no image.jpg", width: 80),
            ),
            OrganismMatchInfo(match: widget.match),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomRow(BuildContext context) {
    final bloc = MessageProvider.of(context);
    final userState = userBloc.state;
    final GlobalKey<FlutterMentionsState> messageKey = GlobalKey();

    if (!socketConnected) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Text(translate("ERRORS.NETWORK.VERIFY_CONNECTION")),
        ),
      );
    }

    final isOwnerOrMember = userState.id == widget.match.user.id || 
        widget.match.joined.any((e) => userState.id == e.id) || 
        isInMatch;

    if (!isOwnerOrMember) {
      return FormButton(
        text: "Join to match",
        color: Colors.transparent,
        onPressed: () {
          try {
            backgroundService.invoke("join_to_match", {"match": widget.match.id});
          } catch (e) {
            debugPrint(e.toString());
          }
        },
      );
    }

    return _buildMessageInput(bloc, messageKey);
  }

  Widget _buildMessageInput(MessageInputBloc bloc, GlobalKey<FlutterMentionsState> messageKey) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Wrap(
      children: [
        Container(
          width: screenWidth * 0.8,
          margin: const EdgeInsets.only(right: 8),
          child: InputGroupMessage(
            inputKey: messageKey,
            usersList: widget.match.joined,
            stream: bloc.messageStream,
            placeholder: "Message",
            onChanged: bloc.changeMessage,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: ElevatedButton(
            onPressed: () => _handleSubmit(bloc, messageKey),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: const StadiumBorder(),
              side: const BorderSide(color: Color.fromARGB(255, 65, 169, 255)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            child: const Icon(Icons.send_outlined),
          ),
        ),
      ],
    );
  }

  void _handleSubmit(MessageInputBloc bloc, GlobalKey<FlutterMentionsState> messageKey) {
    if (bloc.message.isEmpty) return;
    debugPrint("¡Invoking new message from view!");
    backgroundService.invoke(
      "new_message", 
      {"text": bloc.message, "to": widget.match.id, "type": 2}
    );
    bloc.changeMessage("");
    messageKey.currentState?.controller?.clear();
  }
}

class MoleculeRoomMessages extends StatefulWidget {
  final String room;
  const MoleculeRoomMessages({super.key, required this.room});

  @override
  State<MoleculeRoomMessages> createState() => _MoleculeRoomMessagesState();
}

class _MoleculeRoomMessagesState extends State<MoleculeRoomMessages> {
  final _scrollController = ScrollController();
  late final MessageBloc _messageBloc;
  late final FlutterBackgroundService _backgroundService;
  StreamSubscription? _messageSubscription;

  @override
  void initState() {
    super.initState();
    _messageBloc = context.read<MessageBloc>();
    _backgroundService = FlutterBackgroundService();
    _scrollController.addListener(_onScroll);
    _setupMessageListener();
    _messageBloc.add(GroupMessageFetched(roomId: widget.room));
  }

  void _setupMessageListener() {
    _messageSubscription = _backgroundService.on("message").listen((onData) {
      if (mounted && onData != null && onData['user'] is! String) {
        final message = GroupMessage.fromJson(onData);
        if (message.to == widget.room && 
            (_messageBloc.state.groupMessages.isEmpty || 
             message.id != _messageBloc.state.groupMessages[0].id)) {
          _messageBloc.add(AddRoomMessage(message: message));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        if (state.status == MessageStatus.failure && state.groupMessages.isEmpty) {
          return const Center(child: Text("Failed fetching messages"));
        }
        if (state.groupMessages.isEmpty && state.hasReachedMax) {
          return const Center(child: Text('Say hi'));
        }

        if (state.status == MessageStatus.initial && state.groupMessages.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }


        return _buildMessageList(state);
      },
    );
  }

  Widget _buildMessageList(MessageState state) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      color: Colors.black38,
      child: ListView.builder(
        controller: _scrollController,
        shrinkWrap: false,
        addAutomaticKeepAlives: true,
        reverse: true,
        itemCount: state.groupMessages.length,
        itemBuilder: (context, index) {
          final isMainMessage = index == 0 || 
              state.groupMessages[index].user.id != state.groupMessages[index - 1].user.id;
          
          return GroupChatMessageOrganism(
            text: state.groupMessages[index].text,
            user: state.groupMessages[index].user,
            mainMessage: isMainMessage,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageBloc.add(RestoreState());
    _messageSubscription?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      _messageBloc.add(GroupMessageFetched(roomId: widget.room));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    return _scrollController.offset >= (_scrollController.position.maxScrollExtent * 0.9);
  }
}