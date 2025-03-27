import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/chat/user_messages.body.dart';
import 'package:madnolia/services/messages_service.dart';
import 'package:madnolia/widgets/atoms/messages/atom_individual_message.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

import '../../widgets/organism/input/organism_chat_input.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {

    String userId = ''; 
    if (GoRouterState.of(context).extra != null) {
      if (GoRouterState.of(context).extra is String) {
        userId = GoRouterState.of(context).extra as String;
      }
    } else{
      context.go('/');
    }
    return CustomScaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
            color: Colors.black45,
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider("https://i.beeimg.com/images/thumb/z66297834451-xs.jpg"),
                  radius: 30,
                ),
                const Column(
                  children: [
                    Text("NAME"),
                    Text("@username", style: TextStyle(fontSize: 6),)
                  ],
                ),
                Expanded(child: Container() ),
                IconButton(
                  onPressed: () {  },
                  icon: const Icon(Icons.call_outlined),
                  ),
                  IconButton(
                  onPressed: () {
                    ///Set both animation and reverse animation,
                    ///combination different animation and reverse animation to achieve amazing effect.
                    showToastWidget(
                      Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.black45,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: (){},
                              icon: Row(
                                children: [
                                  const Text("Answer"),
                                  IconButton(icon: const Icon(Icons.call), onPressed: () { ToastManager().dismissAll(); },)
                                ],
                              ), 
                            ),
                            IconButton(
                              onPressed: (){},
                              icon: Row(
                                children: [
                                  const Text("Refuse"),
                                  IconButton(icon: const Icon(Icons.call_end_outlined), onPressed: () { ToastManager().dismissAll(); },)
                                ],
                              ),
                              
                            )
                          ],
                        ),
                      ),
                      isIgnoring: false,
                      context: context,
                      animation: StyledToastAnimation.slideFromTopFade,
                      reverseAnimation: StyledToastAnimation.fade,
                      position: StyledToastPosition.top,
                      animDuration: const Duration(milliseconds: 500),
                      duration: const Duration(seconds: 30),
                      curve: Curves.decelerate,
                      reverseCurve: Curves.linear,
                    );
                  },
                  icon: const Icon(CupertinoIcons.video_camera),
                  )
              ],
            ),
          ),
          Expanded(child: MoleculeChatMessages(user: userId)),
          const SizedBox(height: 3),
          const OrganismChatInput(),
          const SizedBox(height: 5),
        ],
      )
      );
  }
}

class MoleculeChatMessages extends StatelessWidget {
  final String user;
  const MoleculeChatMessages({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    const int skip = 0;
    return FutureBuilder(
      future: getChatMessages(UserMessagesBody(user: user, skip: skip)),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          if(snapshot.data is List){
            return Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                color: Colors.black38,
                child: ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, i) => AtomIndividualMessage(message: snapshot.data[i])),
              ),
            );
          }else {
            return const Text('Error loading messages');
          }
        }else {
          return const Flexible(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future getChatMessages(UserMessagesBody payload) async {
    return await MessagesService().getUserChatMessages(payload);
  }
}