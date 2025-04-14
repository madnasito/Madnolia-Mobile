import 'package:madnolia/models/match/match_with_game_model.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/widgets/atoms/game_image_atom.dart';

class GameCard extends StatelessWidget {
  final String name;
  final String? background;
  final Widget bottom;
  const GameCard({super.key,required this.name,  required this.background, required this.bottom});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(bottom: 10, top: 2),
      child: Column(
        children: [
          AtomGameImage(name: name, background: background,),
          bottom
        ],
      ),
    );
  }
}

class MatchCard extends StatelessWidget {
  final MatchWithGame match;
  final Widget bottom;
  const MatchCard({super.key, required this.match, required this.bottom});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(bottom: 10, top: 2),
      child: Column(
        children: [
          AtomGameImage(name: match.game.name, background: match.game.background,),
          bottom
        ],
      ),
    );
  }
}

