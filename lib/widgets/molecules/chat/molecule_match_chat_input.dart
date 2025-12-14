import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/enums/chat_message_type.enum.dart';
import 'package:madnolia/enums/match-status.enum.dart';
import 'package:madnolia/models/chat/create_message_model.dart';
import 'package:madnolia/widgets/atoms/buttons/atom_join_match_button.dart';
import 'package:madnolia/widgets/atoms/input/atom_group_chat_input.dart';
import 'package:uuid/uuid.dart';

import '../../../database/database.dart' show MatchData;

class MoleculeMatchChatInput extends StatefulWidget {
  final MatchData match;
  final String conversation;
  final ChatMessageType messageType;
  final Function(MatchData) onMatchUpdated; // New callback
  const MoleculeMatchChatInput({super.key, required this.conversation, required this.messageType, required this.match, required this.onMatchUpdated});

  @override
  State<MoleculeMatchChatInput> createState() => _MoleculeMatchChatInputState();
}

class _MoleculeMatchChatInputState extends State<MoleculeMatchChatInput> {

  final GlobalKey<FlutterMentionsState> messageKey = GlobalKey();
  late UserBloc userBloc;
  String _text = '';

  @override
  Widget build(BuildContext context) {

    userBloc = context.read<UserBloc>();
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    final backgroundService = FlutterBackgroundService();

    if(widget.match.status == MatchStatus.cancelled || widget.match.status == MatchStatus.finished) { 
      return Container(
        width: double.infinity,
        color: Colors.black87,
        padding: const EdgeInsets.all(16),
        child: Text(translate('MATCH.MATCH_ENDED'), textAlign: TextAlign.center,),
      );
    }
    
    final List<String> usersLists = widget.match.joined.where((member) => member != userBloc.state.id).toList();
    if(userBloc.state.id != widget.match.user) usersLists.add(widget.match.user);
    final bool isOwner = widget.match.user == userBloc.state.id;
    final bool isJoined = widget.match.joined.contains(userBloc.state.id);

    if(!isJoined && !isOwner) {
      return AtomJoinMatchButton(match: widget.match, onJoined: (newMatch){
        widget.onMatchUpdated(newMatch);
      },);
    }

    return Wrap(
      children: [
        SizedBox(width: screenWidth * 0.85, child: AtomGroupChatInput(inputKey: messageKey, usersList: usersLists, onChanged: (text) {
          setState(() {
            _text = text;
          });
        },)),
        IconButton(
          style: IconButton.styleFrom(
            padding: const EdgeInsets.all(9),
          ),
            icon: Icon(Icons.send, color: _text.isEmpty ? Colors.grey : Colors.blue),
            onPressed: () {
              
              if(_text.isEmpty) return;

              final String id = const Uuid().v4();
              backgroundService.invoke(
                "new_message", 
                CreateMessage(id: id, conversation: widget.conversation, content: _text, type: widget.messageType).toJson()
              );

              messageKey.currentState!.controller?.text = '';
            },),
      ],
    );
  }
}
