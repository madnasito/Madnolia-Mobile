import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/match/match_with_game_model.dart';
import 'package:madnolia/widgets/match_card_widget.dart' show MatchCard;

class MoleculeMatchesList extends StatelessWidget {
  final List<MatchWithGame> matches;
  const MoleculeMatchesList({super.key, required this.matches});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: matches.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            GoRouter.of(context)
                .push('/match/${matches[index].id}',);
          },
          child: MatchCard(
              match: matches[index],
              bottom: Column(
                children: [
                  Text(matches[index].title),
                  Text(DateTime.fromMillisecondsSinceEpoch(
                          matches[index].date)
                      .toString()
                      .substring(0, 19))
                ],
              )),
        );
      });
  }
}