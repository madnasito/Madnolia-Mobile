import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/enums/message_type.enum.dart';
import 'package:madnolia/models/chat/individual_message_model.dart';
import 'package:madnolia/models/chat/user_messages.body.dart';
import 'package:madnolia/widgets/atoms/messages/atom_individual_message.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/molecules/chat/molecule_chat_input.dart';


class UserChatPage extends StatelessWidget {
  const UserChatPage({super.key});

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
      body: BlocProvider(
        create: (context) => MessageBloc()..add(UserMessageFetched(messagesBody: UserMessagesBody(user: userId, skip: 0))),
        child: Column(
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
            MoleculeChatInput(to: userId, messageType: MessageType.user),
            const SizedBox(height: 5),
          ],
        ),
      )
      );
  }
}

class MoleculeChatMessages extends StatefulWidget {
  final String user;
  const MoleculeChatMessages({super.key, required this.user});

  @override
  State<MoleculeChatMessages> createState() => _MoleculeChatMessagesState();
}

class _MoleculeChatMessagesState extends State<MoleculeChatMessages> {

  final _scrollController = ScrollController();
  late MessageBloc _messageBloc;
  late FlutterBackgroundService _backgroundService;
  late UserBloc _userBloc;
  int skip = 0;

  void _addMessage(Map<String, dynamic> onData){
    final IndividualMessage message = IndividualMessage.fromJson(onData);

    if((message.user == _userBloc.state.id && message.to == widget.user) || (message.to == _userBloc.state.id && message.user == widget.user)){
      setState(() {    
        _messageBloc.add(AddIndividualMessage(message: message));
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _messageBloc = context.read<MessageBloc>();
    _backgroundService = FlutterBackgroundService();
    _userBloc = context.read<UserBloc>();

    if(mounted){
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
            if(state.messages.isEmpty) {
              return const Center(child: Text('no posts'));
              }
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                color: Colors.black38,
                child: ListView.builder(
                  shrinkWrap: false,
                  addAutomaticKeepAlives: true,
                  reverse: true,
                  itemBuilder: (BuildContext context,int index) {
                    return index >= state.messages.length
                      ? const CircularProgressIndicator()
                      : AtomIndividualMessage(message: state.messages[index]);
                  } ,
                  itemCount: state.hasReachedMax
                    ? state.messages.length
                    : state.messages.length + 1,
                  controller: _scrollController,
                ),
              );
          case MessageStatus.initial:
            if(state.hasReachedMax){
              return Center(child: Text("No messages here"),);
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
    _messageBloc.add(RestoreState());
    super.dispose();
  }

  void _onScroll() {
    debugPrint(_isBottom.toString());
    if (_isBottom) {
      context.read<MessageBloc>().add(UserMessageFetched(messagesBody: UserMessagesBody(user: widget.user, skip: skip)));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}