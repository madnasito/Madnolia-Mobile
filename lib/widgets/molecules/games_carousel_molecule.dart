import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/models/game/minimal_game_model.dart';
import 'package:madnolia/widgets/match_card_widget.dart';

class GamesCarouseMolecule extends StatelessWidget {
  final List<MinimalGame> games;
  final void Function()? onTap;
  const GamesCarouseMolecule({super.key, required this.games, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: games.length, 
      itemBuilder: (BuildContext context, int index, int realIndex) { 
        final MinimalGame game = games[index];
        return GestureDetector(
          onTap: onTap,
          child: GameCard(name: game.name, background: game.background, bottom: Container()),
        );
       },
        options: CarouselOptions(
          viewportFraction: 0.7,
          disableCenter: true,
          enlargeCenterPage: true),
          disableGesture: true, 
      );
  }
}