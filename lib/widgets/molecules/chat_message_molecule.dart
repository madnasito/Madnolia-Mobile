import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/widgets/atoms/icons/message_status_icon.dart';
// import 'package:madnolia/utils/user_db_util.dart';
import 'package:url_launcher/url_launcher.dart' show launchUrl;

class MyMessageMolecule extends StatelessWidget {
  final UserData user;
  final ChatMessageData messageData;
  final bool mainMessage;

  const MyMessageMolecule({
    super.key,
    required this.messageData,
    required this.mainMessage,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.7;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          margin: EdgeInsets.only(bottom: mainMessage ? 10 : 2, right: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              width: 1,
              color: Colors.blue.withValues(alpha: 0.5),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(mainMessage ? 0 : 15),
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ExpandableText(
                    messageData.content,
                    expandText: translate("UTILS.SHOW_MORE"),
                    collapseText: translate("UTILS.SHOW_LESS"),
                    maxLines: 6,
                    animation: true,
                    collapseOnTextTap: true,
                    expandOnTextTap: true,
                    mentionStyle: TextStyle(color: Colors.greenAccent),
                    onMentionTap: (value) => debugPrint('Mention $value'),
                    onUrlTap: (value) async {
                      final Uri url = Uri.parse(value);
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    urlStyle: const TextStyle(
                      color: Color.fromARGB(255, 169, 145, 255),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    DateFormat.Hm().format(messageData.date),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withValues(alpha: 0.6)),
                  ),
                  const SizedBox(width: 4),
                  AtomMessageStatusIcon(status: messageData.status, size: 12),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: mainMessage ? 10 : 2, left: 2),
          child: CircleAvatar(
            backgroundImage:
                mainMessage ? CachedNetworkImageProvider(user.thumb) : null,
            backgroundColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}

class NotMyMessageMolecule extends StatelessWidget {
  final UserData? user;
  final ChatMessageData messageData;
  final bool mainMessage;

  const NotMyMessageMolecule(
      {super.key,
      this.user,
      required this.messageData,
      required this.mainMessage});

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.7;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          child: Container(
            margin: EdgeInsets.only(
                left: 2, right: 4, bottom: mainMessage ? 10 : 2),
            child: CircleAvatar(
              backgroundImage:
                  mainMessage ? CachedNetworkImageProvider(user!.thumb) : null,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          margin: EdgeInsets.only(bottom: mainMessage ? 10 : 2, left: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              width: 1,
              color: Colors.white.withValues(alpha: 0.2),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(mainMessage ? 0 : 15),
              bottomRight: Radius.circular(15),
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ExpandableText(
                    messageData.content,
                    expandText: translate("UTILS.SHOW_MORE"),
                    collapseText: translate("UTILS.SHOW_LESS"),
                    maxLines: 6,
                    animation: true,
                    collapseOnTextTap: true,
                    expandOnTextTap: true,
                    mentionStyle: TextStyle(color: Colors.greenAccent),
                    onMentionTap: (value) => debugPrint('Mention $value'),
                    onUrlTap: (value) async {
                      final Uri url = Uri.parse(value);
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    urlStyle: const TextStyle(
                      color: Color.fromARGB(255, 169, 145, 255),
                    ),
                  ),
                ),
              ),
              Text(
                DateFormat.Hm().format(messageData.date),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withValues(alpha: 0.6)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}