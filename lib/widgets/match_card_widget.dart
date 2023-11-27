import 'package:flutter/material.dart';

import '../models/game_model.dart';

class MatchCard extends StatelessWidget {
  final Game game;
  final Widget bottom;
  const MatchCard({super.key, required this.game, required this.bottom});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(bottom: 10, top: 2),
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(game.backgroundImage),
              Positioned(
                  bottom: 2,
                  left: 2,
                  child: Text(
                    game.name,
                    style: const TextStyle(
                        backgroundColor: Colors.black54, fontSize: 15),
                  ))
            ],
          ),
          bottom
        ],
      ),
    );
  }
}
