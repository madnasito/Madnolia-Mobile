import 'package:flutter/material.dart';
import 'package:madnolia/services/messages_service.dart';

import '../../models/chat/message_model.dart';
import 'chat_message_organism.dart';

class ChatOrganism extends StatefulWidget {
  final String match;
  const ChatOrganism({super.key, required this.match});

  @override
  State<ChatOrganism> createState() => _ChatOrganismState();
}

class _ChatOrganismState extends State<ChatOrganism> {
  @override
  Widget build(BuildContext context) {

    int page = 0;

    return FutureBuilder(
      future: MessagesService().getMatchMessages(widget.match, page),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if(snapshot.hasData){ 

          String lastUser = "";
          List<ChatMessageOrganism> messages = snapshot.data!.map((e) {
              final isTheSame = e.user.id == lastUser ? false: true;
              lastUser = e.user.id;
              return  ChatMessageOrganism(
                text: e.text,
                user: e.user,
                mainMessage: isTheSame);
            })
            .toList();

          final scrollController = ScrollController();
          scrollController.addListener(
            () async{
                if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
                  final resp = await MessagesService().getMatchMessages(widget.match, page);
                  List<ChatMessageOrganism> newMessages = resp.map((e) {
                    final isTheSame = e.user.id == lastUser ? false: true;
                    lastUser = e.user.id;
                    return  ChatMessageOrganism(
                      text: e.text,
                      user: e.user,
                      mainMessage: isTheSame);
                  })
                  .toList();

                  messages.addAll(newMessages);

                  page++;
                  setState(() {
                    
                  });
              }
            }
        );
          return Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
              color: Colors.black38,
              child: ListView.builder(
                controller: scrollController,
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (_, i) => messages[i])
              )
            );
        } else{
          return const Center(child: CircularProgressIndicator());
        }
      }
    );

    
  }
}