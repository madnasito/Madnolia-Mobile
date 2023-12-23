import 'package:flutter/material.dart';
import 'package:Madnolia/blocs/message_bloc.dart';

import 'package:Madnolia/models/match_model.dart';
import 'package:Madnolia/models/message_model.dart';
import 'package:Madnolia/providers/user_provider.dart';
import 'package:Madnolia/services/match_service.dart';
import 'package:Madnolia/services/sockets_service.dart';
import 'package:Madnolia/widgets/chat_message_widget.dart';
import 'package:Madnolia/widgets/custom_input_widget.dart';
import 'package:provider/provider.dart';

class MatchOwnerView extends StatelessWidget {
  final Match match;
  const MatchOwnerView({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(match.img != null ? match.img.toString() : ""),
              Positioned(
                bottom: 2,
                left: 2,
                child: Text(
                  match.gameName,
                  style: const TextStyle(backgroundColor: Colors.black54),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MatchUserView extends StatelessWidget {
  final Match match;
  const MatchUserView({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MatchChat extends StatefulWidget {
  final Match match;
  final MessageBloc bloc;
  const MatchChat({super.key, required this.match, required this.bloc});

  @override
  State<MatchChat> createState() => _MatchChatState();
}

class _MatchChatState extends State<MatchChat> with TickerProviderStateMixin {
  final List _messages = [];
  final matchService = MatchService();
  late UserProvider userProvider;

  late SocketService socketService;
  late TextEditingController messageController;
  void _loadHistory(String id) async {
    final resp = await matchService.getMatch(id);

    if (resp["ok"] == false) {
      return;
    }

    final respMessages = resp["chat"];

    List history = respMessages.map((e) => Message.fromJson(e)).toList();
    List<Widget> messages = history
        .map((e) => ChatMessage(
            text: e.text,
            user: e.user,
            animationController: AnimationController(
                vsync: this, duration: const Duration(milliseconds: 0))
              ..forward()))
        .toList();

    // mensajes.map((e) => ChatMessage(
    //     text: e["mensaje"],
    //     username: e["from"],
    // animationController: AnimationController(
    //     vsync: this, duration: const Duration(milliseconds: 0))
    //   ..forward()));

    setState(() {
      _messages.addAll(messages.reversed);
    });
  }

  void _listenMessage(Map<String, dynamic> payload) {
    Message decodedMessage = Message.fromJson(payload);

    ChatMessage message = ChatMessage(
        text: decodedMessage.text,
        user: decodedMessage.user,
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 300)));

    setState(() {
      _messages.insert(0, message);
    });

    message.animationController.forward();
  }

  @override
  void initState() {
    super.initState();
    _loadHistory(widget.match.id);
    messageController = TextEditingController();
    socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on("message", (data) => _listenMessage(data));

    socketService.emit("init_match_chat", widget.match.id);
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    socketService.socket.off("message");
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
                    widget.match.message,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    widget.match.gameName,
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
                  widget.match.img.toString(),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                width: 270,
                child: CustomInput(
                    controller: messageController,
                    placeholder: "Message",
                    stream: widget.bloc.messageStream,
                    onChanged: widget.bloc.changeMessage),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: ElevatedButton(
                  onPressed: () {
                    _handleSubmit(widget.bloc.message);
                    widget.bloc.changeMessage("");
                    messageController.text = "";
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: const StadiumBorder(),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 65, 169, 255),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10)),
                  child: const Icon(Icons.send_outlined),
                ),
              )
              // ElevatedButton.icon(
              //     onPressed: () {}, icon: Icon(Icons.abc), label: Text(""))
            ],
          ),
        )
      ],
    );
  }

  _handleSubmit(String text) {
    if (text.isEmpty) return;

    // final userService = Provider.of<UserProvider>(context, listen: false);
    // final newMessage = ChatMessage(
    //     text: text,
    //     user: User(
    //         thumbImg: userService.user.thumbImg.toString(),
    //         id: "",
    //         name: userService.user.name,
    //         username: userService.user.username),
    //     animationController: AnimationController(
    //         vsync: this, duration: const Duration(milliseconds: 200)));

    // _messages.insert(0, newMessage);

    // newMessage.animationController.forward();
    socketService.emit("message", text);
    setState(() {});
  }
}
