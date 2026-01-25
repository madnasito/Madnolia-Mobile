import 'dart:math' as math show min;

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/blocs/matches/matches_bloc.dart';
import 'package:madnolia/models/match/matches-filter.model.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/widgets/atoms/text_atoms/atom_styled_text.dart';
import 'package:madnolia/widgets/molecules/buttons/molecule_matches_filter_buttons.dart';
import 'package:madnolia/widgets/organism/organism_load_matches.dart'
    show OrganismLoadMatches;

import '../../enums/sort_type.enum.dart' show SortType;

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  late final _scrollController = ScrollController();
  late final MatchesBloc matchesBloc;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    matchesBloc = context.read<MatchesBloc>();
    super.initState();
  }

  void _onScroll() {
    if (_isBottom) {
      final matchesState = matchesBloc.state.matchesState.firstWhere(
        (e) => e.type == matchesBloc.state.selectedType,
      );
      matchesBloc.add(
        LoadMatches(
          filter: MatchesFilter(
            type: matchesBloc.state.selectedType,
            sort: SortType.desc,
            cursor: matchesState.matches.isNotEmpty
                ? matchesState.matches.last.match.id
                : null,
          ),
        ),
      );
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
    return BlocListener<MatchesBloc, MatchesState>(
      listener: (context, state) {
        if (state.matchesState.isEmpty) {
          context.read<MatchesBloc>().add(InitialState());
        }
      },
      child: CustomMaterialIndicator(
        onRefresh: () async {
          context.read<MatchesBloc>().add(InitialState());
        },
        backgroundColor: Colors.white,
        indicatorBuilder: (context, controller) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: CircularProgressIndicator(
              color: Colors.lightBlue,
              value: controller.state.isLoading
                  ? null
                  : math.min(controller.value, 1.0),
            ),
          );
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              AtomStyledText(
                text: t.PROFILE.MATCHES,
                style: neonTitleText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const MoleculeMatchesFilterButtons(),
              // Positioned(child: child)
              const SizedBox(height: 15),
              const OrganismLoadMatches(),
            ],
          ),
        ),
      ),
    );
  }
}
