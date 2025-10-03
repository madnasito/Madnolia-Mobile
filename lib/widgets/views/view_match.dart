import 'dart:async' show StreamSubscription;

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/database/match/match.services.dart';
import 'package:madnolia/enums/list_status.enum.dart' show ListStatus;
import 'package:madnolia/enums/match-status.enum.dart';
import 'package:madnolia/services/match_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/blocs/message/message_bloc.dart';
import 'package:madnolia/blocs/message_provider.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';
import 'package:madnolia/models/chat/message_model.dart';
import 'package:madnolia/widgets/atoms/media/game_image_atom.dart';
import 'package:madnolia/widgets/chat/input_widget.dart';
import 'package:madnolia/widgets/form_button.dart';
import 'package:madnolia/widgets/organism/chat_message_organism.dart';
import 'package:madnolia/widgets/organism/organism_match_info.dart';

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
  bool _isLoading = false;
  String? _errorMessage;
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
      if(data?["match"] != widget.match.id) return;
      setState(() {
        
      });
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
    // backgroundService.invoke("new_player_to_match");
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
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: SizedBox(
                  width: 90,
                  child: widget.game.background != null ? AtomGameImage(
                    background: resizeImage(widget.game.background! 
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
                    "gameName": widget.game.name,
                    "match": "https://madnolia.app/match/${widget.match.id}"
                    })
                  // uri: Uri.parse('https://madnolia.app/match/${widget.match.id}')
                );
      
                final result = await SharePlus.instance.share(params);
      
                debugPrint(result.status.toString());
              }, icon: Icon(Icons.share_outlined)),
              OrganismMatchInfo(match: widget.match, game: widget.game, userId: widget.match.user,),
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

    if(widget.match.status == MatchStatus.cancelled || widget.match.status == MatchStatus.finished) { 
      return Container(
        width: double.infinity,
        color: Colors.black87,
        padding: const EdgeInsets.all(16),
        child: Text(translate('MATCH.MATCH_ENDED'), textAlign: TextAlign.center,),
      );
    }

    final isOwnerOrMember = userState.id == widget.match.user || 
        widget.match.joined.any((e) => userState.id == e) || 
        isInMatch;

    if (!isOwnerOrMember) {
      if (_isLoading) {
        return const Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(child: CircularProgressIndicator()),
        );
      }

      return Column(
        children: [
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          FormButton(
            text: translate('MATCH.JOIN_TO_MATCH'),
            color: Colors.transparent,
            onPressed: () async {
              setState(() {
                _isLoading = true;
                _errorMessage = null;
              });
              try {
                final resp = await MatchService().join(widget.match.id);
                debugPrint(resp.toString());

                await MatchDbServices().joinUser(widget.match.id, userState.id);

                setState(() {
                  isInMatch = true;
                  _isLoading = false;
                });

              } catch (e) {
                debugPrint(e.toString());
                setState(() {
                  _errorMessage = translate('MATCH.ERRORS.JOIN_FAILED');
                  _isLoading = false;
                });
              }
            },
          ),
        ],
      );
    }

    return _buildMessageInput(bloc, messageKey, socketConnected);
  }

  Widget _buildMessageInput(MessageInputBloc bloc, GlobalKey<FlutterMentionsState> messageKey, bool socketConnected) {
    final screenWidth = MediaQuery.of(context).size.width;

    final List<String> usersLists = widget.match.joined.where((member) => member != userBloc.state.id).toList();
    if(userBloc.state.id != widget.match.user) usersLists.add(widget.match.user);
    
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
  late List<UserData> chatUsers;

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
        
        return BuildMessageList(scrollController: _scrollController, state: state);

      },
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

class BuildMessageList extends StatelessWidget {

  final MessageState state;
  final ScrollController scrollController;
  const BuildMessageList({super.key, required this.state, required this.scrollController});

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
      itemCount: state.groupMessages.length,
      itemBuilder: (context, index) {
        
        final message = state.groupMessages[index];
        UserData user = state.users.firstWhere((user) => message.creator == user.id);


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
}
