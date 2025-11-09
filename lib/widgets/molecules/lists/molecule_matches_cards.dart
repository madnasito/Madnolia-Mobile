import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/match/match_with_game_model.dart';
import 'package:madnolia/widgets/match_card_widget.dart';

class MoleculeMatchesCards extends StatelessWidget {
  final List<MatchWithGame> matches;

  const MoleculeMatchesCards({super.key, required this.matches});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: matches.length,
      itemBuilder: (context, index) => AtomMatchCard(data: matches[index]),
    );
  }
}

class AtomMatchCard extends StatelessWidget {
  final MatchWithGame data;

  const AtomMatchCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push('/match/${data.match.id}'),
      child: MatchCard(
        data: data,
      ),
    );
  }
}