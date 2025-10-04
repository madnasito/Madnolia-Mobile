import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/blocs/chats/chats_bloc.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';
import 'package:madnolia/models/chat/chat_message_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AtomIndividualMessage extends StatefulWidget {
  final ChatMessage message;
  const AtomIndividualMessage({super.key, required this.message});

  @override
  State<AtomIndividualMessage> createState() => _AtomIndividualMessageState();
}

class _AtomIndividualMessageState extends State<AtomIndividualMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late FlutterBackgroundService backgroundService;

  @override
  void initState() {
    backgroundService = FlutterBackgroundService();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myId = context.read<UserBloc>().state.id;
    final chatsBloc = context.watch<ChatsBloc>();

    return VisibilityDetector(
      key: Key(widget.message.id),
      onVisibilityChanged: (info) {
        if(info.visibleFraction > 0 && widget.message.status == ChatMessageStatus.sent && widget.message.creator != myId) {
          debugPrint('${widget.message.text}: ${widget.message.status}');
          backgroundService.invoke('update_recipient_status', {'id': widget.message.id, 'status': ChatMessageStatus.read.index});
          chatsBloc.add(UpdateRecipientStatus(messageId: widget.message.id, status: ChatMessageStatus.read));
        }
      },
      child: Align(
        alignment:
          widget.message.creator == myId ? Alignment.centerRight : Alignment.centerLeft,
          child: Container( // Removed Flexible
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: widget.message.creator == myId ? Colors.lightBlueAccent : Colors.white54, width: 0.5),
            ),
            child: ExpandableText(
              widget.message.text,
              expandText: "↓ ${translate('UTILS.SHOW_MORE')}",
              collapseText: "↑ ${translate('UTILS.SHOW_LESS')}",
              maxLines: 6,
              animation: true,
              collapseOnTextTap: true,
              expandOnTextTap: true,
              onUrlTap: (value) async {
                final Uri url = Uri.parse(value);
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch $url');
                }
              },
              urlStyle: const TextStyle(
                color: Color.fromARGB(255, 169, 145, 255)
              ),
          ),
        ),
      ),
    );
  }
}