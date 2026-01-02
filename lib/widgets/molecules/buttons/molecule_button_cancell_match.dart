import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/services/match_service.dart';
import 'package:madnolia/widgets/alert_widget.dart';
import 'package:toast/toast.dart';

class MoleculeButtonCancellMatch extends StatelessWidget {
  final MatchData match;
  final GameData game;
  const MoleculeButtonCancellMatch({super.key, required this.match, required this.game});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () { 
        showDialog(
          context: context, 
          builder: (BuildContext context) { 
            return AlertDialog(
              backgroundColor: Colors.black26,
              actionsAlignment: MainAxisAlignment.center,
              contentPadding: EdgeInsets.only(bottom: 10, top: 20),
              actionsPadding: const EdgeInsets.all(0),
              titleTextStyle: const TextStyle(fontSize: 20),
              icon: game.background != null ? CircleAvatar(
                radius: 50,
                backgroundImage: CachedNetworkImageProvider(game.background!) 
              ) : null,
              title: Text(t.MATCH.CANCELL_MATCH_QUESTION, textAlign: TextAlign.center),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();                    
                  }, 
                  child: Text(t.UTILS.NO)
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      await MatchService().cancellMatch(match.id);
                      if(!context.mounted) return;
                      Toast.show(t.MATCH.MATCH_CANCELLED,
                        gravity: 100,
                        border: Border.all(color: Colors.blueAccent),
                        textStyle: const TextStyle(fontSize: 18),
                        duration: 3
                      );
                      GoRouter.of(context).pushReplacement('/matches');
                      ToastContext().init(context);
                    } catch (e) {
                      debugPrint(e.toString());
                      if(e is Map) showErrorServerAlert(context, e);
                    }
                  }, 
                  child: Text(t.UTILS.YES)
                ),
              ],
            );
          }
        );
       },
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          Icon(Icons.cancel, color: Colors.red),
          Text(t.MATCH.CANCEL_MATCH)
        ],
      ),
    );
  }
}