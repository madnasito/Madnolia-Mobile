import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/player_matches/player_matches_bloc.dart';
import 'package:madnolia/enums/list_status.enum.dart';
import 'package:madnolia/models/match/match_with_game_model.dart';
import 'package:madnolia/models/match/matches-filter.model.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/widgets/atoms/text_atoms/atom_styled_text.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/match_card_widget.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlayerMatchesBloc, PlayerMatchesState>(
      listener: (context, state) {
        if (state.matchesState.isEmpty) {
          context.read<PlayerMatchesBloc>().add(InitialState());
        }
      },
      child: CustomScaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AtomStyledText(
                text: 'Matches',
                style: neonTitleText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              BlocBuilder<PlayerMatchesBloc, PlayerMatchesState>(
                builder: (context, state) {
                  return SegmentedButton(
                    segments: [
                      ButtonSegment(value: MatchesFilterType.all, label: Text('All')),
                      ButtonSegment(value: MatchesFilterType.created, label: Text('Created')),
                      ButtonSegment(value: MatchesFilterType.joined, label: Text('Joined')),
                    ],
                    selected: <MatchesFilterType>{state.selectedType},
                    onSelectionChanged: (value) => context
                        .read<PlayerMatchesBloc>()
                        .add(UpdateFilterType(type: value.first)),
                  );
                },
              ),
              const OrganismLoadMatches(),
            ],
          ),
        ),
      ),
    );
  }
}

class OrganismLoadMatches extends StatelessWidget {
  const OrganismLoadMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerMatchesBloc, PlayerMatchesState>(
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
            context.read<PlayerMatchesBloc>().add(
                  UpdateFilterType(type: state.selectedType),
                );
            return const Center(child: CircularProgressIndicator());
          }

          if (matchesState.status == ListStatus.success) {
            if (matchesState.matches.isEmpty) {
              return const Center(child: Text('No matches found'));
            }
            return _MatchesList(matches: matchesState.matches);
          }

          if (matchesState.status == ListStatus.failure) {
            if (matchesState.matches.isEmpty) {
              return const Center(child: Text('Error loading matches'));
            }
            return Column(
              children: [
                _MatchesList(matches: matchesState.matches),
                const Text('Error loading more matches'),
              ],
            );
          }

          return const Center(child: Text('Unknown state'));
        } catch (e) {
          return const Center(child: Text('Error loading matches'));
        }
      },
    );
  }
}

class _MatchesList extends StatelessWidget {
  final List<MatchWithGame> matches;

  const _MatchesList({required this.matches});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: matches.length,
      itemBuilder: (context, index) => _MatchItem(match: matches[index]),
    );
  }
}

class _MatchItem extends StatelessWidget {
  final MatchWithGame match;

  const _MatchItem({required this.match});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push('/match/${match.id}'),
      child: MatchCard(
        match: match,
        bottom: Column(
          children: [
            Text(match.title),
            // Text(
            //   DateFormat('yyyy-MM-dd HH:mm:ss').format(
            //     DateTime.fromMillisecondsSinceEpoch(match.date),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}