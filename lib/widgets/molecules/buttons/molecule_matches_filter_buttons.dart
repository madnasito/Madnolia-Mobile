import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/blocs/matches/matches_bloc.dart';
import 'package:madnolia/models/match/matches-filter.model.dart';

class MoleculeMatchesFilterButtons extends StatelessWidget {
  const MoleculeMatchesFilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchesBloc, MatchesState>(
      builder: (context, state) {
        return SegmentedButton(
          showSelectedIcon: false,
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
              label: Text(translate('MATCHES.ALL'), textAlign: TextAlign.center)
              ,
            ),
            ButtonSegment(
              value: MatchesFilterType.created,
              label: Text(translate('MATCHES.CREATED'), textAlign: TextAlign.center)
              ,
            ),
            ButtonSegment(
              value: MatchesFilterType.joined,
              label:  Text(translate('MATCHES.JOINED'), textAlign: TextAlign.center)
              ,
            ),
          ],
          selected: <MatchesFilterType>{state.selectedType},
          onSelectionChanged: (value) => context
            .read<MatchesBloc>()
            .add(UpdateFilterType(type: value.first)
          ),
        );
      },
    );
  }
}
