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
  final backgroundService = FlutterBackgroundService();

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();

    if (mounted) {
      backgroundService.invoke("init");
      // backgroundService.on("message").listen((data) => _listenMessage(data!));
      backgroundService.on("new_player_to_match").listen((data) {
        ChatUser user = ChatUser.fromJson(data!);
        debugPrint(user.name);
      });
      backgroundService.on("added_to_match").listen((data) {
        if (data?["resp"] == true) {
          isInMatch = true;
          if (mounted) {
            setState(() {});
          }
        }
      });

      backgroundService.invoke("init_chat", {"room": widget.match.id});

      backgroundService
        .on("disconnected_socket")
        .listen((payload) => setState(() {
              socketConnected = false;
            }));

      backgroundService.on("connected_socket").listen((payload) => setState(() {
            socketConnected = true;
          }));

      userBloc.updateChatRoom(widget.match.id);
    }
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
       Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    widget.match.title,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    widget.match.game.name,
                    style: const TextStyle(fontSize: 6),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.only(right: 10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: widget.match.game.background != null
                        ? CachedNetworkImage(
                            imageUrl: widget.match.game.background!, width: 80)
                        : Image.asset("assets/no image.jpg", width: 80),
                  ),
                  OrganismMatchInfo(match: widget.match),
                ],
              ),
            ],
          ),
          Expanded(
            child: MoleculeRoomMessages(room: widget.match.id)
          ),
          // MoleculeChatInput(to: widget.match.id, messageType: MessageType.match),
          _bottomRow(context, widget.match, userBloc.state, isInMatch, socketConnected )
      ],
    );
  }

  Widget _bottomRow(BuildContext context, FullMatch match, UserState userState, bool isInMatch, bool socketConnected) {
    
    final bloc = MessageProvider.of(context);
    
    bool owner = userState.id == match.user.id ? true : false;
    List<ChatUser> founded =
        match.joined.where((e) => userState.id == e.id).toList();

    final backgroundService = FlutterBackgroundService();

    GlobalKey<FlutterMentionsState> messageKey = GlobalKey<FlutterMentionsState>();

    if (owner || founded.isNotEmpty || isInMatch) {
      isInMatch = true;
      Size screenSize = MediaQuery.of(context).size;

      double screenWidth = screenSize.width;

      if (!socketConnected) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Text(translate("ERRORS.NETWORK.VERIFY_CONNECTION")),
        ));
      }
      return Wrap(
        children: [
          Container(
            width: screenWidth * 0.8,
            margin: const EdgeInsets.only(right: 8),
            child: InputGroupMessage(
              inputKey: messageKey,
              usersList: match.joined,
              stream: bloc.messageStream,
              placeholder: "Message",
              onChanged: bloc.changeMessage,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: ElevatedButton(
              onPressed: () {
                _handleSubmit(bloc.message);
                bloc.changeMessage("");
                messageKey.currentState?.controller?.clear();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: const StadiumBorder(),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 65, 169, 255),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
              child: const Icon(Icons.send_outlined),
            ),
          ),
          // ElevatedButton.icon(
          //     onPressed: () {}, icon: Icon(Icons.abc), label: Text(""))
        ],
      );
    } else {
      return FormButton(
          text: "Join to match",
          color: Colors.transparent,
          onPressed: () {
            try {
              backgroundService.invoke("join_to_match", {"match": match.id});
            } catch (e) {
              debugPrint(e.toString());
            }
          });
    }
  }

  void _handleSubmit(String text) {
    if (text.isEmpty) return;
    final backgroundService = FlutterBackgroundService();
    debugPrint("¡Invoking new message from view!");
    backgroundService.invoke(
        "new_message", {"text": text, "to": widget.match.id, "type": 2});
  }
}

class MoleculeRoomMessages extends StatefulWidget {
  final String room;
  const MoleculeRoomMessages({super.key, required this.room});

  @override
  State<MoleculeRoomMessages> createState() => _MolecMoleculeRoomMessages();
}

class _MolecMoleculeRoomMessages extends State<MoleculeRoomMessages> {
  final _scrollController = ScrollController();
  late MessageBloc _messageBloc;
  late FlutterBackgroundService _backgroundService;
  int skip = 0;

  void _addMessage(Map<String, dynamic> onData) {
    final GroupMessage message = GroupMessage.fromJson(onData);

    if (message.to == widget.room) {
      setState(() {
        _messageBloc.add(AddRoomMessage(message: message));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _messageBloc = context.read<MessageBloc>();
    _messageBloc.add(GroupMessageFetched(roomId: widget.room));
    _backgroundService = FlutterBackgroundService();

    if (mounted) {
      _backgroundService.on("message").listen((onData) => _addMessage(onData!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          switch (state.status) {
            case MessageStatus.failure:
              return const Center(child: Text("Failed fetching messages"));
            case MessageStatus.success:
              if (state.groupMessages.isEmpty) {
                return const Center(child: Text('No messages'));
              }
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                color: Colors.black38,
                // child: Center(child: Text("Loaded messages")),
                child: ListView.builder(
                  shrinkWrap: false,
                  addAutomaticKeepAlives: true, 
                  reverse: true,
                  itemBuilder: (BuildContext context,int index) {

                    bool mainMessage = false;
                    if(index < state.groupMessages.length){
                      if (state.groupMessages.isEmpty) {
                        mainMessage = false;
                      }
                      else if(index > 0){
                        final message = state.groupMessages[index];

                        if(message.user.id == state.groupMessages[index - 1].user.id){
                          mainMessage = false;
                        }else {
                          mainMessage = true;
                        }
                      }else {
                        mainMessage = true;
                      }
                      //  else if (state.groupMessages[0].user.id == state.groupMessages[index].user.id) {
                      //   mainMessage = false;
                      // } else {
                      //   mainMessage = true;
                      // }                  
                    }
                    return index >= state.groupMessages.length
                      ? const CircularProgressIndicator()
                      : GroupChatMessageOrganism(
                        text: state.groupMessages[index].text,
                        user: state.groupMessages[index].user,
                        mainMessage: mainMessage
                      );
                  } ,
                  itemCount: state.hasReachedMax
                    ? state.groupMessages.length
                    : state.groupMessages.length + 1,
                  controller: _scrollController,
                ),
              );
            case MessageStatus.initial:
              if (state.hasReachedMax) {
                return Center(
                  child: Text("No messages here"),
                );
              }
              return const Center(child: CircularProgressIndicator());
          }
        },
        // bloc: MessageBloc(),
      
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // _messageBloc.add(RestoreState());
    super.dispose();
  }

  void _onScroll() {
    debugPrint(_isBottom.toString());
    if (_isBottom) {
      context.read<MessageBloc>().add(GroupMessageFetched(roomId: widget.room));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}