import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/database/database.dart';
import 'package:url_launcher/url_launcher.dart';

class AtomMyIndividualMessage extends StatefulWidget {
  final ChatMessageData message;
  const AtomMyIndividualMessage({super.key, required this.message});

  @override
  State<AtomMyIndividualMessage> createState() => _AtomMyIndividualMessageState();
}

class _AtomMyIndividualMessageState extends State<AtomMyIndividualMessage> with SingleTickerProviderStateMixin {

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

    return Align(
        alignment:Alignment.centerRight,
          child: Container( // Removed Flexible
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.lightBlueAccent),
            ),
            child: ExpandableText(
              widget.message.content,
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
      );
  }
}