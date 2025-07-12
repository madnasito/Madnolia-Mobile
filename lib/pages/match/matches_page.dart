import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/blocs/player_matches/player_matches_bloc.dart';
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
          AtomStyledText(text: 'Matches', style: neonTitleText),
          SizedBox(height: 20),
          SegmentedButton(segments: [
            ButtonSegment(value: 'all', icon: Text('All')),
            ButtonSegment(value: 'created', icon: Text('Created')),
            ButtonSegment(value: 'joined', icon: Text('Joined')),
          ], selected: {'all'}, )
        ],
      ),
    ));
  }
}