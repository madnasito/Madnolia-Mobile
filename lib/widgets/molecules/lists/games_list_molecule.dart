import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/game/minimal_game_model.dart';
import 'package:madnolia/models/game_model.dart';
import 'package:madnolia/widgets/match_card_widget.dart';

class GamesListMolecule extends StatelessWidget {
  final List<MinimalGame> games;
  final void Function()? onTap;
  final int? platform;
  const GamesListMolecule({super.key, required this.games, this.onTap, this.platform});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: games.length,
      itemBuilder: (BuildContext context, int index) {
      final game = games[index];
      return GestureDetector(
        onTap: onTap ?? ()  {
          final gameMatch = Game(name: game.name, backgroundImage: game.background, id: game.gameId);
          context.push("/new/match",
          extra: {
            "game": gameMatch,
            "platformId": platform
            }
          );
        },
        child: GameCard(name: game.name, background: game.background, bottom: Container()),
      );
    });
  }
}