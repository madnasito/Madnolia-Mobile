import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/models/match/full_match.model.dart';
import 'package:madnolia/widgets/alert_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/blocs/message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/widgets/organism/organism_match_info.dart';

// import 'package:socket_io_client/socket_io_client.dart';

import '../../models/chat/message_model.dart';
import 'package:madnolia/services/match_service.dart';
import 'package:madnolia/widgets/organism/chat_message_organism.dart';
import 'package:flutter_mentions/flutter_mentions.dart';

import '../../models/chat_user_model.dart';

class MatchChat extends StatefulWidget {
  final FullMatch match;
  final List matchMessages;
  final MessageInputBloc bloc;

  const MatchChat(
      {super.key,
      required this.match,
      required this.bloc,
      required this.matchMessages});

  @override
  State<MatchChat> createState() => _MatchChatState();
}

class _MatchChatState extends State<MatchChat> {
  bool isInMatch = false;
  bool socketConnected = true;
  final List<GroupChatMessageOrganism> _messages = [];
  final matchService = MatchService();
  late UserBloc userBloc;
  final backgroundService = FlutterBackgroundService();

  late GlobalKey<FlutterMentionsState> messageKey;
  void _loadHistory(String id) async {
    final resp = await matchService.getMatch(id);

    // Check if the widget is still mounted before proceeding
    if (!mounted) return;

    if (resp.containsKey("error")) {
      return showErrorServerAlert(context, resp);
    }

    List<GroupMessage> history =
        widget.matchMessages.map((e) => GroupMessage.fromJson(e)).toList();

    String lastUser = "";
    List<GroupChatMessageOrganism> messages = history.map((e) {
      final isTheSame = e.user.id == lastUser ? false : true;
      lastUser = e.user.id;
      return GroupChatMessageOrganism(
          text: e.text, user: e.user, mainMessage: isTheSame);
    }).toList();

    setState(() {
      _messages.addAll(messages);
    });
  }

  void _listenMessage(Map<String, dynamic> payload) async {
    if (!mounted) {
      return;
    }

    GroupMessage decodedMessage = GroupMessage.fromJson(payload);

    if (decodedMessage.to != widget.match.id) return;

    bool mainMessage = false;

    if (_messages.isEmpty) {
      mainMessage = true;
    } else if (_messages[0].user.id == decodedMessage.user.id) {
      mainMessage = false;
    } else {
      mainMessage = true;
    }

    GroupChatMessageOrganism message = GroupChatMessageOrganism(
        mainMessage: mainMessage,
        text: decodedMessage.text,
        user: decodedMessage.user);

    // await LocalNotificationsService.displayMessage(decodedMessage);

    setState(() {
      _messages.insert(0, message);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadHistory(widget.match.id);
    messageKey = GlobalKey<FlutterMentionsState>();
    userBloc = context.read<UserBloc>();

    if (mounted) {
      backgroundService.invoke("init");
      backgroundService.on("message").listen((data) => _listenMessage(data!));
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
    backgroundService
        .on("disconnected_socket")
        .listen((payload) => setState(() {
              socketConnected = false;
            }));

    backgroundService.on("connected_socket").listen((payload) => setState(() {
          socketConnected = true;
        }));
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
                  OrganismMatchInfo(match: widget.match)
                ],
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 35,
        //   child: MaterialButton(

        //     height: 25,
        //     color: Colors.pink,
        //     onPressed: () {
        //       context.pushNamed("match_call", extra: widget.match);
        //      },
        //     child: Stack(
        //         alignment: AlignmentDirectional.centerStart,

        //         children: [
        //           const Positioned(
        //             left: 10,
        //             child: Text("Join to voice chat")
        //           ),
        //           ..._activeUsers(widget.match.joined)
        //         ],
        //       ),
        //   ),
        // ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
            color: Colors.black38,
            child: MoleculeRoomMessages(room: widget.match.id),
            // child: ListView.builder(
            //     reverse: true,
            //     itemCount: _messages.length,
            //     physics: const BouncingScrollPhysics(),
            //     itemBuilder: (_, i) => _messages[i]),
          ),
        ),
        // Container(
        //     color: Colors.black54,
        //     padding: const EdgeInsets.only(top: 10),
        //     child: _bottomRow(
        //         widget.match, userBloc.state, isInMatch, socketConnected))
      ],
    );
  }

  // Widget _bottomRow(FullMatch match, UserState userState, bool isInMatch,
  //     bool socketConnected) {
  //   if (!mounted) {
  //     return const CircularProgressIndicator();
  //   }
  //   bool owner = userState.id == match.user.id ? true : false;
  //   List<ChatUser> founded =
  //       match.joined.where((e) => userState.id == e.id).toList();

  //   if (owner || founded.isNotEmpty || isInMatch) {
  //     isInMatch = true;
  //     Size screenSize = MediaQuery.of(context).size;

  //     double screenWidth = screenSize.width;

  //     if (!socketConnected) {
  //       return Center(
  //           child: Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 7),
  //         child: Text(translate("ERRORS.NETWORK.VERIFY_CONNECTION")),
  //       ));
  //     }
  //     return Wrap(
  //       children: [
  //         Container(
  //           width: screenWidth * 0.8,
  //           margin: const EdgeInsets.only(right: 8),
  //           child: InputGroupMessage(
  //             inputKey: messageKey,
  //             usersList: widget.match.joined,
  //             stream: widget.bloc.messageStream,
  //             placeholder: "Message",
  //             onChanged: widget.bloc.changeMessage,
  //           ),
  //         ),
  //         Container(
  //           margin: const EdgeInsets.only(bottom: 8),
  //           child: ElevatedButton(
  //             onPressed: () {
  //               _handleSubmit(widget.bloc.message);
  //               widget.bloc.changeMessage("");
  //               messageKey.currentState?.controller?.clear();
  //             },
  //             style: ElevatedButton.styleFrom(
  //                 backgroundColor: Colors.transparent,
  //                 shape: const StadiumBorder(),
  //                 side: const BorderSide(
  //                   color: Color.fromARGB(255, 65, 169, 255),
  //                 ),
  //                 padding:
  //                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
  //             child: const Icon(Icons.send_outlined),
  //           ),
  //         ),
  //         // ElevatedButton.icon(
  //         //     onPressed: () {}, icon: Icon(Icons.abc), label: Text(""))
  //       ],
  //     );
  //   } else {
  //     return FormButton(
  //         text: "Join to match",
  //         color: Colors.transparent,
  //         onPressed: () {
  //           try {
  //             backgroundService.invoke("join_to_match", {"match": match.id});
  //           } catch (e) {
  //             debugPrint(e.toString());
  //           }
  //         });
  //   }
  // }

  // void _handleSubmit(String text) {
  //   if (text.isEmpty) return;
  //   debugPrint("¡Invoking new message from view!");
  //   backgroundService.invoke(
  //       "new_message", {"text": text, "to": widget.match.id, "type": 2});
  // }

  // List<Positioned> _activeUsers(List<ChatUser> users) {
  //   List<Positioned> usersThumbs = [];
  //   double separation = 10;
  //   for (var i = 0; i < users.length; i++) {
  //     usersThumbs.add(Positioned(
  //         right: separation,
  //         child: CircleAvatar(
  //           backgroundImage: CachedNetworkImageProvider(users[i].thumb),
  //           radius: 12,
  //         )));
  //     separation += 8;
  //   }

  //   return usersThumbs;
  // }
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
    _backgroundService = FlutterBackgroundService();

    if (mounted) {
      _backgroundService.on("message").listen((onData) => _addMessage(onData!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageBloc()..add(GroupMessageFetched(roomId: widget.room)),
      child: BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          switch (state.status) {
            case MessageStatus.failure:
              return const Center(child: Text("Failed fetching messages"));
            case MessageStatus.success:
              if (state.groupMessages.isEmpty) {
                return const Center(child: Text('no posts'));
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
                    // if(index < state.groupMessages.length){
                    //   if (state.groupMessages.isEmpty) {
                    //     mainMessage = true;
                    //   } else if (state.groupMessages[0].user.id == state.groupMessages[index].user.id) {
                    //     mainMessage = false;
                    //   } else {
                    //     mainMessage = true;
                    //   }                  
                    // }
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
      ),
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
