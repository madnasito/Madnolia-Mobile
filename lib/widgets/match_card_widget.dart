import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/enums/match-status.enum.dart';
import 'package:madnolia/models/match/match_with_game_model.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/widgets/atoms/media/game_image_atom.dart';
import 'package:intl/intl.dart';

class GameCard extends StatelessWidget {
  final String name;
  final String? background;
  final Widget bottom;
  const GameCard({super.key,required this.name,  required this.background, required this.bottom});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(10)),
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
  final MatchWithGame data;

  const MatchCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Define un color y un texto basado en el estado del match
    Color statusColor;
    String statusText;

    switch (data.match.status) {
      case MatchStatus.waiting:
        statusColor = Colors.amberAccent; // Color para "en espera"
        statusText = translate('MATCH.STATUS.WAITING');
        break;
      case MatchStatus.running:
        statusColor = Colors.greenAccent; // Color para "en curso"
        statusText = translate('MATCH.STATUS.RUNNING');
        break;
      case MatchStatus.finished:
        statusColor = Colors.blueGrey; // Color para "terminado"
        statusText = translate('MATCH.STATUS.FINISHED');
        break;
      case MatchStatus.cancelled:
        statusColor = Colors.redAccent; // Color para "cancelado"
        statusText = translate('MATCH.STATUS.CANCELLED');
        break;
    }

    return Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black45,
        blurRadius: 5,
        offset: Offset(0, 3), // Sombra hacia abajo
      ),
    ],
  ),
  margin: const EdgeInsets.only(bottom: 10),
  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AtomGameImage(name: data.game.name, background: data.game.background),
      SizedBox(height: 10),
      Text(
        data.match.title,
        style: TextStyle(
          color: Colors.cyanAccent,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 4),
      Text(
        DateFormat('EEEE, d MMMM yyyy - hh:mm a').format(
          data.match.date,
        ),
        style: TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
      ),
      SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
        decoration: BoxDecoration(
          color: statusColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 5,
              offset: Offset(0, 3), // Sombra hacia abajo
            ),
          ],
        ),
        child: Text(
          statusText,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  ),
);

  }
}


