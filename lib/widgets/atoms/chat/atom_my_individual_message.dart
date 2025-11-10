import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intl/intl.dart';
import 'package:madnolia/database/database.dart';
import 'package:url_launcher/url_launcher.dart';

import '../icons/message_status_icon.dart';

class AtomMyIndividualMessage extends StatelessWidget {
  final ChatMessageData message;
  final bool mainMessage;

  const AtomMyIndividualMessage(
      {super.key, required this.message, required this.mainMessage});

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.75;

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxWidth),
        margin: EdgeInsets.only(bottom: mainMessage ? 10 : 2, right: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            width: 1,
            color: Colors.blue.withValues(alpha: 0.5),
          ),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: const Radius.circular(15),
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
                  message.content,
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
                    color: Color.fromARGB(255, 169, 145, 255),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  DateFormat.Hm().format(message.date),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white.withValues(alpha: 0.6)),
                ),
                const SizedBox(width: 4),
                AtomMessageStatusIcon(
                  status: message.status,
                  size: 12,
                  pending: message.pending,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}