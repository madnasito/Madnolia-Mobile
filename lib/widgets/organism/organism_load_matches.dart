import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/blocs/matches/matches_bloc.dart';
import 'package:madnolia/enums/list_status.enum.dart';
import 'package:madnolia/widgets/molecules/lists/molecule_matches_cards.dart';

class OrganismLoadMatches extends StatelessWidget {
  const OrganismLoadMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchesBloc, MatchesState>(
      builder: (context, state) {
        try {
          final matchesState = state.matchesState.firstWhere(
            (e) => e.type == state.selectedType,
            orElse: () => LoadedMatches(
              type: state.selectedType,
              matches: [],
              status: ListStatus.initial,
              hasReachesMax: false,
            ),
          );

          if (matchesState.status == ListStatus.initial) {
            context.read<MatchesBloc>().add(
                  UpdateFilterType(type: state.selectedType),
                );
            return const Center(child: CircularProgressIndicator());
          }

          if (matchesState.status == ListStatus.success) {
            if (matchesState.matches.isEmpty) {
              return Center(child: Text(t.MATCHES.ERRORS.NO_MATCHES));
            }
            return Column(
              children: [
                MoleculeMatchesCards(matches: matchesState.matches),
                (!matchesState.hasReachesMax) ? CircularProgressIndicator() : SizedBox() 
              ],
            );
          }

          if (matchesState.status == ListStatus.failure) {
            if (matchesState.matches.isEmpty) {
              return Center(child: Text(t.MATCHES.ERRORS.LOADING_ERROR));
            }
            return Column(
              children: [
                MoleculeMatchesCards(matches: matchesState.matches),
                Text(t.MATCHES.ERRORS.LOADING_ERROR),
              ],
            );
          }

          return const Center(child: Text('Unknown state'));
        } catch (e) {
          return Center(child: Text(t.MATCHES.ERRORS.LOADING_ERROR));
        }
      },
    );
  }
}