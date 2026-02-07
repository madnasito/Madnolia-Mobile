import 'dart:async' show StreamSubscription;

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/enums/bloc_status.enum.dart' show BlocStatus;
import 'package:share_plus/share_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/blocs/message/message_bloc.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';
import 'package:madnolia/widgets/atoms/media/game_image_atom.dart';
import 'package:madnolia/widgets/organism/chat_message_organism.dart';
import 'package:madnolia/widgets/organism/organism_match_info.dart';
import 'package:madnolia/widgets/atoms/chat/atom_date_header.dart';
import '../../enums/chat_message_type.enum.dart';
import '../../utils/images_util.dart' show resizeRawgImage;
import '../molecules/chat/molecule_match_chat_input.dart';

class ViewMatch extends StatefulWidget {
  final MatchData match;
  final GameData game;
  const ViewMatch({super.key, required this.match, required this.game});

  @override
  State<ViewMatch> createState() => _ViewMatchState();
}

class _ViewMatchState extends State<ViewMatch> {
  bool isInMatch = false;
  bool socketConnected = true;
  late UserBloc userBloc;
  late final FlutterBackgroundService backgroundService;
  late MatchData _match;

  StreamSubscription? _addedToMatchSubscription;
  StreamSubscription? _socketDisconnectedSubscription;
  StreamSubscription? _socketConnectedSubscription;

  @override
  void initState() {
    super.initState();
    _match = widget.match;
    userBloc = context.read<UserBloc>();
    backgroundService = FlutterBackgroundService();
    _initializeServices();
  }

  void _initializeServices() {
    backgroundService.invoke("init");

    // Guarda las suscripciones para poder cancelarlas después

    _addedToMatchSubscription = backgroundService.on("added_to_match").listen((
      data,
    ) {
      if (!mounted) return;
      if (data?["resp"] == true) {
        isInMatch = true;
        if (mounted) setState(() {});
      }
    });

    backgroundService.invoke("init_chat", {"room": _match.id});

    _socketDisconnectedSubscription = backgroundService
        .on("disconnected_socket")
        .listen((_) {
          if (mounted) setState(() => socketConnected = false);
        });

    _socketConnectedSubscription = backgroundService
        .on("connected_socket")
        .listen((_) {
          if (mounted) setState(() => socketConnected = true);
        });

    userBloc.add(UpdateChatRoom(chatRoom: _match.id));
  }

  @override
  void dispose() {
    // Cancela todas las suscripciones
    _addedToMatchSubscription?.cancel();
    _socketDisconnectedSubscription?.cancel();
    _socketConnectedSubscription?.cancel();

    backgroundService.invoke("disconnect_chat");
    backgroundService.invoke("leave_room");
    // backgroundService.invoke("new_player_to_match");
    userBloc.add(UpdateChatRoom(chatRoom: ''));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMatchHeader(),
        Expanded(child: MoleculeRoomMessages(room: _match.id)),
        MoleculeMatchChatInput(
          match: _match,
          conversation: _match.id,
          messageType: ChatMessageType.match,
          onMatchUpdated: (newMatch) {
            setState(() {
              _match = newMatch;
            });
          },
        ),
      ],
    );
  }

  Widget _buildMatchHeader() {
    return Container(
      color: Colors.black54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            // Asegura que el texto no desborde
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _match.title,
                  style: const TextStyle(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  widget.game.name,
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: 90,
                  child: widget.game.background != null
                      ? AtomGameImage(
                          background: resizeRawgImage(widget.game.background!),
                        )
                      : Image.asset("assets/no image.jpg", fit: BoxFit.cover),
                ),
              ),
              IconButton(
                onPressed: () async {
                  // final String apiUrl = dotenv.get("SOCKETS_URL");
                  final params = ShareParams(
                    title: t.SHARE.TITLE,
                    // uri: Uri.tryParse("https://madnolia.app/match/${_match.id}"),
                    // subject: "🎮 Let's play ${widget.game.name}",
                    text: t.SHARE.TEXT(
                      gameName: widget.game.name,
                      match: "https://madnolia.app/match/${_match.id}",
                    ),
                    // uri: Uri.parse('https://madnolia.app/match/${_match.id}')
                  );

                  final result = await SharePlus.instance.share(params);

                  debugPrint(result.status.toString());
                },
                icon: Icon(Icons.share_outlined),
              ),
              OrganismMatchInfo(
                match: _match,
                game: widget.game,
                userId: _match.user,
              ),
            ],
          ),
        ],
      ),
    );
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
  late List<UserData> chatUsers;

  @override
  void initState() {
    super.initState();
    _messageBloc = context.read<MessageBloc>();
    _messageBloc.add(
      MessageFetched(roomId: widget.room, type: ChatMessageType.match),
    );
    _messageBloc.add(WatchRoomMessages(roomId: widget.room));
    _scrollController.addListener(_onScroll);

    chatUsers = [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        if (state.status == BlocStatus.failure && state.roomMessages.isEmpty) {
          return Center(child: Text(t.CHAT.ERRORS.LOADING_CHAT));
        } else if (state.roomMessages.isEmpty && state.hasReachedMax) {
          return Center(child: Text(t.CHAT.SAY_HI));
        } else if (state.status == BlocStatus.initial &&
            state.roomMessages.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return BuildMessageList(
            scrollController: _scrollController,
            state: state,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageBloc.add(RestoreState());
    super.dispose();
  }

  void _onScroll() {
    debugPrint('Is bottom: $_isBottom');
    if (_isBottom) {
      _messageBloc.add(
        MessageFetched(roomId: widget.room, type: ChatMessageType.match),
      );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    return _scrollController.offset >=
        (_scrollController.position.maxScrollExtent * 0.9);
  }
}

class BuildMessageList extends StatelessWidget {
  final MessageState state;
  final ScrollController scrollController;
  const BuildMessageList({
    super.key,
    required this.state,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      color: Colors.black38,
      child: ListView.builder(
        controller: scrollController,
        cacheExtent: 99999,
        reverse: true,
        addAutomaticKeepAlives: true,
        itemCount: state.roomMessages.length,
        itemBuilder: (context, index) {
          final message = state.roomMessages[index];

          final isMainMessage =
              index == 0 ||
              state.roomMessages[index].chatMessage.creator !=
                  state.roomMessages[index - 1].chatMessage.creator;

          bool showDateHeader = false;
          if (index == state.roomMessages.length - 1) {
            showDateHeader = true;
          } else {
            final nextMessageData = state.roomMessages[index + 1].chatMessage;
            if (message.chatMessage.date.day != nextMessageData.date.day ||
                message.chatMessage.date.month != nextMessageData.date.month ||
                message.chatMessage.date.year != nextMessageData.date.year) {
              showDateHeader = true;
            }
          }

          final messageWidget = GroupChatMessageOrganism(
            messageData: state.roomMessages[index].chatMessage,
            user: message.user,
            mainMessage: isMainMessage,
          );

          if (showDateHeader) {
            return Column(
              children: [
                AtomDateHeader(date: message.chatMessage.date),
                messageWidget,
              ],
            );
          }

          return messageWidget;
        },
      ),
    );
  }
}
