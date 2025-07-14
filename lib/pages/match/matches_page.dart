import 'dart:math' as math show min;

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/player_matches/player_matches_bloc.dart';
import 'package:madnolia/enums/list_status.enum.dart';
import 'package:madnolia/models/match/match_with_game_model.dart';
import 'package:madnolia/models/match/matches-filter.model.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/widgets/atoms/text_atoms/atom_styled_text.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/match_card_widget.dart';

import '../../enums/sort_type.enum.dart' show SortType;

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {

  late final _scrollController = ScrollController();
  late final PlayerMatchesBloc playerMatchesBloc;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    playerMatchesBloc = context.read<PlayerMatchesBloc>();
    super.initState();
  }

  void _onScroll() {
    if (_isBottom) {
      final matchesState = playerMatchesBloc.state.matchesState.firstWhere((e) => e.type == playerMatchesBloc.state.selectedType);
      playerMatchesBloc.add(FetchMatchesType(
        filter: MatchesFilter(type: playerMatchesBloc.state.selectedType, sort: SortType.desc, skip: matchesState.matches.length)
      ));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    return _scrollController.offset >=
        (_scrollController.position.maxScrollExtent * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    
    return BlocListener<PlayerMatchesBloc, PlayerMatchesState>(
      listener: (context, state) {
        if (state.matchesState.isEmpty) {
          context.read<PlayerMatchesBloc>().add(InitialState());
        }
      },
      child: CustomScaffold(
        body: CustomMaterialIndicator(
          onRefresh: () async { 
              context.read<PlayerMatchesBloc>().add(InitialState());
             },
             backgroundColor: Colors.white,
             indicatorBuilder: (context, controller) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: CircularProgressIndicator(
                  color: Colors.lightBlue,
                  value: controller.state.isLoading ? null : math.min(controller.value, 1.0),
                ),
              );
            },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                AtomStyledText(
                  text: translate("PROFILE.MATCHES"),
                  style: neonTitleText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                BlocBuilder<PlayerMatchesBloc, PlayerMatchesState>(
                  builder: (context, state) {
                    return SegmentedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                            // Black background when selected
                            if (states.contains(WidgetState.selected)) {
                              return Colors.black54;
                            }
                            // Transparent (or another color) when not selected
                            return Colors.transparent;
                          }),
                          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                            // Amber text when selected
                            if (states.contains(WidgetState.selected)) {
                              return Colors.amber;
                            }
                            // Grey text when not selected
                            return Colors.grey;
                          }),
                          // Optional: Add a border for better visibility
                          side: WidgetStateProperty.all(BorderSide(color: Colors.grey)),
                          // Optional: Remove extra padding
                          visualDensity: VisualDensity.compact,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      segments: [
                        ButtonSegment(
                          value: MatchesFilterType.all,
                          label: SizedBox(width: 50, child: Text('All', textAlign: TextAlign.center)),
                        ),
                        ButtonSegment(
                          value: MatchesFilterType.created,
                          label: SizedBox(width: 50, child: Text('Created', textAlign: TextAlign.center)),
                        ),
                        ButtonSegment(
                          value: MatchesFilterType.joined,
                          label: SizedBox(width: 50, child: Text('Joined', textAlign: TextAlign.center)),
                        ),
                      ],
                      selected: <MatchesFilterType>{state.selectedType},
                      onSelectionChanged: (value) => context
                          .read<PlayerMatchesBloc>()
                          .add(UpdateFilterType(type: value.first)),
                    );
                  },
                ),
                // Positioned(child: child)
                const SizedBox(height: 10),
                const OrganismLoadMatches(),
              ],
            ),
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
            return Column(
              children: [
                _MatchesList(matches: matchesState.matches),
                (!matchesState.hasReachesMax) ? CircularProgressIndicator() : SizedBox() 
              ],
            );
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