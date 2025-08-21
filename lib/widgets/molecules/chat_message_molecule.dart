import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/database/providers/user_db.dart';
// import 'package:madnolia/utils/user_db_util.dart';
import 'package:url_launcher/url_launcher.dart' show launchUrl;

class MyMessageMolecule extends StatelessWidget {
  final UserDb user;
  final String text;
  final bool mainMessage;
  
  const MyMessageMolecule({
    super.key, 
    required this.text, 
    required this.mainMessage, 
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.7;
    
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              margin: EdgeInsets.only(bottom: mainMessage ? 10 : 0),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blue, width: 0.5),
              ),
              child: ExpandableText(
                text,
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
          Container(
            margin: EdgeInsets.only(bottom: mainMessage ? 10 : 2, left: 2),
            child: CircleAvatar(
              backgroundImage: mainMessage ? CachedNetworkImageProvider(user.thumb) : null,
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );  
  }
}

class NotMyMessageMolecule extends StatelessWidget {
  final UserDb? user;
  final String text;
  final bool mainMessage;
  
  const NotMyMessageMolecule({
    super.key, 
    this.user, 
    required this.text, 
    required this.mainMessage
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width * 0.7;
    
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(left: 2, right: 4, bottom: mainMessage ? 10 : 2),
              child: CircleAvatar(
                backgroundImage: mainMessage ? CachedNetworkImageProvider(user!.thumb) : null,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              margin: EdgeInsets.only(bottom: mainMessage ? 10 : 2),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white38, width: 0.5),
              ),
              child: ExpandableText(
                text,
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
        ],
      ),
    );
  }
}