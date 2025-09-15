import 'dart:async' show StreamSubscription;

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/enums/list_status.enum.dart' show ListStatus;
import 'package:share_plus/share_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/blocs/message/message_bloc.dart';
import 'package:madnolia/blocs/message_provider.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';
import 'package:madnolia/models/chat/message_model.dart';
import 'package:madnolia/models/chat_user_model.dart';
import 'package:madnolia/widgets/atoms/game_image_atom.dart';
import 'package:madnolia/widgets/chat/input_widget.dart';
import 'package:madnolia/widgets/form_button.dart';
import 'package:madnolia/widgets/organism/chat_message_organism.dart';
import 'package:madnolia/widgets/organism/organism_match_info.dart';
import '../../database/providers/user_db.dart' show UserDb;

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
  
  StreamSubscription? _newPlayerSubscription;
  StreamSubscription? _addedToMatchSubscription;
  StreamSubscription? _socketDisconnectedSubscription;
  StreamSubscription? _socketConnectedSubscription;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();
    backgroundService = FlutterBackgroundService();
    _initializeServices();
  }

  void _initializeServices() {
    backgroundService.invoke("init");
    
    // Guarda las suscripciones para poder cancelarlas después
    _newPlayerSubscription = backgroundService.on("new_player_to_match").listen((data) {
      if (!mounted) return;
      ChatUser user = ChatUser.fromJson(data!);
      debugPrint(user.name);
    });
    
    _addedToMatchSubscription = backgroundService.on("added_to_match").listen((data) {
      if (!mounted) return;
      if (data?["resp"] == true) {
        isInMatch = true;
        if (mounted) setState(() {});
      }
    });
    
    backgroundService.invoke("init_chat", {"room": widget.match.id});
    
    _socketDisconnectedSubscription = backgroundService.on("disconnected_socket").listen((_) {
      if (mounted) setState(() => socketConnected = false);
    });
    
    _socketConnectedSubscription = backgroundService.on("connected_socket").listen((_) {
      if (mounted) setState(() => socketConnected = true);
    });
    
    userBloc.updateChatRoom(widget.match.id);
  }

  @override
  void dispose() {
    // Cancela todas las suscripciones
    _newPlayerSubscription?.cancel();
    _addedToMatchSubscription?.cancel();
    _socketDisconnectedSubscription?.cancel();
    _socketConnectedSubscription?.cancel();
    
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
    return Container(
      color: Colors.black54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible( // Asegura que el texto no desborde
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.match.title,
                  style: const TextStyle(fontSize: 20),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  widget.match.game.name,
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
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: SizedBox(
                  width: 90,
                  child: widget.match.game.background != null ? AtomGameImage(
                    background: resizeImage(widget.match.game.background! 
                    )
                  ) : Image.asset("assets/no image.jpg", fit: BoxFit.cover) ),
              ),
              IconButton(onPressed: () async{
                // final String apiUrl = dotenv.get("SOCKETS_URL");
                final params = ShareParams(
                  title: translate("SHARE.TITLE"),
                  // uri: Uri.tryParse("https://madnolia.app/match/${widget.match.id}"),
                  // subject: "🎮 Let's play ${widget.match.game.name}",
                  text: translate("SHARE.TEXT", args: {
                    "gameName": widget.match.game.name,
                    "match": "https://madnolia.app/match/${widget.match.id}"
                    })
                  // uri: Uri.parse('https://madnolia.app/match/${widget.match.id}')
                );
      
                final result = await SharePlus.instance.share(params);
      
                debugPrint(result.status.toString());
              }, icon: Icon(Icons.share_outlined)),
              OrganismMatchInfo(match: widget.match),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomRow(BuildContext context) {
    final bloc = MessageProvider.of(context);
    final userState = userBloc.state;
    final GlobalKey<FlutterMentionsState> messageKey = GlobalKey();

    // if (!socketConnected) {
    //   return Center(
    //     child: Padding(
    //       padding: const EdgeInsets.symmetric(vertical: 7),
    //       child: Text(translate("ERRORS.NETWORK.VERIFY_CONNECTION")),
    //     ),
    //   );
    // }

    final isOwnerOrMember = userState.id == widget.match.user.id || 
        widget.match.joined.any((e) => userState.id == e.id) || 
        isInMatch;

    if (!isOwnerOrMember) {
      return FormButton(
        text: translate('MATCH.JOIN_TO_MATCH'),
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

    return _buildMessageInput(bloc, messageKey, socketConnected);
  }

  Widget _buildMessageInput(MessageInputBloc bloc, GlobalKey<FlutterMentionsState> messageKey, bool socketConnected) {
    final screenWidth = MediaQuery.of(context).size.width;

    final List<ChatUser> usersLists = widget.match.joined.where((member) => member.id != userBloc.state.id).toList();
    if(userBloc.state.id != widget.match.user.id) usersLists.add(widget.match.user);
    
    return Wrap(
      children: [
        Container(
          width: screenWidth * 0.8,
          margin: const EdgeInsets.only(right: 8),
          child: InputGroupMessage(
            inputKey: messageKey,
            usersList: usersLists,
            stream: bloc.messageStream,
            placeholder: translate('CHAT.MESSAGE'),
            onChanged: bloc.changeMessage,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: ElevatedButton(
            onPressed: () => _handleSubmit(bloc, messageKey, socketConnected),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: const StadiumBorder(),
              side: const BorderSide(color: Color.fromARGB(255, 65, 169, 255)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
            child: const Icon(Icons.send_outlined),
          ),
        ),
        socketConnected ? Container() :  Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 8),
          child: Text(translate("ERRORS.NETWORK.VERIFY_CONNECTION", ), textAlign: TextAlign.center,))
      ],
    );
  }

  void _handleSubmit(MessageInputBloc bloc, GlobalKey<FlutterMentionsState> messageKey, socketConnected) {
    if (bloc.message.isEmpty || !socketConnected) return;
    backgroundService.invoke(
      "new_message", 
      {"text": bloc.message, "conversation": widget.match.id, "type": 2}
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
  late List<UserDb> chatUsers;

  @override
  void initState() {
    super.initState();
    _messageBloc = context.read<MessageBloc>();
    _backgroundService = FlutterBackgroundService();
    _scrollController.addListener(_onScroll);
    _setupMessageListener();
    _messageBloc.add(GroupMessageFetched(roomId: widget.room));
    chatUsers = [];
  }

  void _setupMessageListener() {
    _messageSubscription = _backgroundService.on("message").listen((onData) {

    debugPrint("¡Invoking new message from view!");
      // if (!mounted) return; // Verifica si el widget está montado
      
      if (onData != null) {
        final message = ChatMessage.fromJson(onData);
        if (message.conversation == widget.room && 
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
        if (state.status == ListStatus.failure && state.groupMessages.isEmpty) {
          return Center(child: Text(translate('CHAT.ERRORS.LOADING')));
        }
        if (state.groupMessages.isEmpty && state.hasReachedMax) {
          return Center(child: Text(translate('CHAT.SAY_HI')));
        }

        if (state.status == ListStatus.initial && state.groupMessages.isEmpty) {
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
      cacheExtent: 99999,
      reverse: true,
      addAutomaticKeepAlives: true,
      itemCount: state.groupMessages.length,
      itemBuilder: (context, index) {
        
        final message = state.groupMessages[index];
        UserDb user = state.users.firstWhere((user) => message.creator == user.id);


        final isMainMessage = index == 0 || 
            state.groupMessages[index].creator != state.groupMessages[index - 1].creator;
        
        return GroupChatMessageOrganism(
          text: state.groupMessages[index].text,
          user: user,
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