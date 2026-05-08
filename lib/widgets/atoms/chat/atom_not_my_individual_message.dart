import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/enums/events/sockets_events.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:intl/intl.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../database/database.dart';
import '../../../models/chat/update_recipient_model.dart';

class AtomNotMyIndividualMessage extends StatelessWidget {
  final ChatMessageData message;
  final bool isLast;

  const AtomNotMyIndividualMessage({
    super.key,
    required this.message,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundService = FlutterBackgroundService();
    final maxWidth = MediaQuery.of(context).size.width * 0.75;

    return VisibilityDetector(
      key: Key(message.id),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0 &&
            message.status == ChatMessageStatus.sent) {
          debugPrint('${message.content}: ${message.status}');
          backgroundService.invoke(
            ChatMessageEvents.updateRecipientStatus.event,
            UpdateRecipientModel(
              id: message.id,
              status: ChatMessageStatus.read,
            ).toJson(),
          );
        }
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          margin: EdgeInsets.only(bottom: isLast ? 10 : 2, left: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              width: 1,
              color: Colors.white.withValues(alpha: 0.2),
            ),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15),
              topRight: const Radius.circular(15),
              bottomLeft: Radius.circular(isLast ? 0 : 15),
              bottomRight: const Radius.circular(15),
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
                    message.content,
                    expandText: "↓ ${t.UTILS.SHOW_MORE}",
                    collapseText: "↑ ${t.UTILS.SHOW_LESS}",
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
                      color: Color.fromARGB(255, 169, 145, 255),
                    ),
                  ),
                ),
              ),
              Text(
                DateFormat.Hm().format(message.date),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
