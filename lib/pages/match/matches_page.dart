import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/blocs/player_matches/player_matches_bloc.dart';
import 'package:madnolia/models/match/matches-filter.model.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/widgets/atoms/text_atoms/atom_styled_text.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {

    final playerMatchesBloc = context.watch<PlayerMatchesBloc>();

    if(playerMatchesBloc.state.matchesState.isEmpty) playerMatchesBloc.add(InitialState());

    return CustomScaffold(body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AtomStyledText(text: 'Matches', style: neonTitleText, textAlign: TextAlign.center,),
          SizedBox(height: 20),
          SegmentedButton(
            segments: [
            ButtonSegment(value: MatchesFilterType.all, icon: Text('All')),
            ButtonSegment(value: MatchesFilterType.created, icon: Text('Created')),
            ButtonSegment(value: MatchesFilterType.joined, icon: Text('Joined')),
          ], selected: <MatchesFilterType>{playerMatchesBloc.state.selectedType},
          onSelectionChanged: (value) => playerMatchesBloc.add(UpdateFilterType(type: value.first )), )
        ],
      ),
    ));
  }
}

class OrganismLoadMatches extends StatelessWidget {
  const OrganismLoadMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}