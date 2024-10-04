import 'package:Madnolia/blocs/blocs.dart';
import 'package:Madnolia/models/match/full_match.model.dart';
import 'package:Madnolia/models/match/match_with_game_model.dart';
import 'package:Madnolia/widgets/chat/input_widget.dart';
import 'package:Madnolia/widgets/form_button.dart';
import 'package:flutter/material.dart';
import 'package:Madnolia/blocs/message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../models/chat/message_model.dart';
import 'package:Madnolia/services/match_service.dart';
import 'package:Madnolia/widgets/chat/chat_message_widget.dart';
import 'package:flutter_mentions/flutter_mentions.dart';


import '../models/chat_user_model.dart';

class MatchUserView extends StatelessWidget {
  final MatchWithGame match;
  const MatchUserView({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MatchChat extends StatefulWidget {
  final FullMatch match;
  final List matchMessages;
  final MessageBloc bloc;
  final Socket socketClient;

  const MatchChat(
      {super.key,
      required this.match,
      required this.bloc,
      required this.matchMessages, required this.socketClient});

  @override
  State<MatchChat> createState() => _MatchChatState();
}

class _MatchChatState extends State<MatchChat> with TickerProviderStateMixin {
  bool isInMatch = false;
  final List<ChatMessage> _messages = [];
  final matchService = MatchService();
  late UserBloc userBloc;
  // late Socket socketClient;

  late GlobalKey<FlutterMentionsState> messageKey;
  void _loadHistory(String id) async {
    final resp = await matchService.getMatch(id);

    if (resp.containsKey("error")) {
      return;
    }

    // final respMessages = resp["match"]["chat"];

    List<Message> history =
        widget.matchMessages.map((e) => Message.fromJson(e)).toList();
        
    String lastUser = "";
    List<ChatMessage> messages = history
        .map((e) {
          final isTheSame = e.user.id == lastUser ? false: true;
          lastUser = e.user.id;
          return  ChatMessage(
            text: e.text,
            user: e.user,
            mainMessage: isTheSame,
            animationController: AnimationController(
                vsync: this, duration: const Duration(milliseconds: 0))
              ..forward());
        })
        .toList();

    setState(() {
      _messages.addAll(messages.reversed);
    });
  }

  void _listenMessage(Map<String, dynamic> payload) {
    if (!mounted) {
      return;
    }
    Message decodedMessage = Message.fromJson(payload);

    if (decodedMessage.room != widget.match.id) return;

    
    ChatMessage message = ChatMessage(
      mainMessage: _messages[0].user.username == decodedMessage.user.username ? false : true,
      text: decodedMessage.text,
      user: decodedMessage.user,
      animationController: AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300))
    );

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }


  @override
  void initState() {
    super.initState();
    _loadHistory(widget.match.id);
    messageKey = GlobalKey<FlutterMentionsState>();
    // socketClient = context.read<SocketsBloc>().state.clientSocket;
    userBloc = context.read<UserBloc>();

    if (mounted) {
      widget.socketClient.on("message", (data) => _listenMessage(data));
      widget.socketClient.on("new_player_to_match", (data) {
        ChatUser user = ChatUser.fromJson(data);

        debugPrint("USER NAME");
        debugPrint(user.name);
      });
      widget.socketClient.on("added_to_match", (data) {
        if (data == true) {
          isInMatch = true;
          setState(() {});
        }
      });

      widget.socketClient.emit("init_chat", widget.match.id);

      userBloc.updateChatRoom(widget.match.id);

    }
  }

  @override
  void dispose() {
    widget.socketClient.emit("disconnect_chat");
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    widget.socketClient.off("message");
    widget.socketClient.off("new_player_to_match");
    

    
    userBloc.updateChatRoom("");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        Container(
          color: Colors.black54,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
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
              Container(
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Image.network(
                  filterQuality: FilterQuality.medium,
                  widget.match.game.background.toString(),
                  width: 80,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
            color: Colors.black38,
            child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, i) => _messages[i]),
          ),
        ),
        Container(
            color: Colors.black54,
            padding: const EdgeInsets.only(top: 10),
            child: _bottomRow(widget.match, userBloc.state, isInMatch))
      ],
    );
  }

  Widget _bottomRow(FullMatch match, UserState userState, bool isInMatch) {
    bool owner = userState.id == match.user ? true : false;
    List<dynamic> founded =
        match.likes.where((e) => userState.id == e).toList();

    print(match.likes);

    if (owner || founded.isNotEmpty || isInMatch) {
      isInMatch = true;
      Size screenSize = MediaQuery.of(context).size;

      double screenWidth = screenSize.width;
      return Wrap(
        children: [
          Container(
            width: screenWidth * 0.8,
            margin: const EdgeInsets.only(right: 8),
            child: InputGroupMessage(
              inputKey: messageKey,
              usersList: widget.match.likes,
              stream: widget.bloc.messageStream,
              placeholder: "Message",
              onChanged: widget.bloc.changeMessage,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: ElevatedButton(
              onPressed: () {
                _handleSubmit(widget.bloc.message);
                widget.bloc.changeMessage("");
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
            widget.socketClient.emit("join_to_match", match.id);
          });
    }
  }

  void _handleSubmit(String text) {
    if (text.isEmpty) return;
    widget.socketClient.emit("message", {"text": text, "room": widget.match.id});
    setState(() {});
  }
}
