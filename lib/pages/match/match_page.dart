import 'package:madnolia/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/database/repository_manager.dart';
import 'package:madnolia/models/match/match_with_game_model.dart';
import 'package:madnolia/services/local_notifications_service.dart';
import 'package:madnolia/widgets/views/view_match.dart';

class MatchPage extends StatelessWidget {
  final String id;

  const MatchPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadMatchWithGame(id),
      builder: (BuildContext context, AsyncSnapshot<MatchWithGame> snapshot) {
        if (snapshot.hasData) {
          return ViewMatch(
            match: snapshot.data!.match,
            game: snapshot.data!.game,
          );
        } else if (snapshot.hasError) {
          return Center(child: Text(t.MATCH.ERROR_LOADING));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<MatchWithGame> _loadMatchWithGame(String id) async {
    LocalNotificationsService.deleteRoomMessages(id);
    final matchWithGame = await RepositoryManager().match.getMatchWithGame(id);
    return matchWithGame;
  }
}
