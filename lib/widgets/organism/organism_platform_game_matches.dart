import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/blocs/platform_game_matches/platform_game_matches_bloc.dart';
import 'package:madnolia/enums/list_status.enum.dart';
import 'package:madnolia/widgets/molecules/lists/molecule_platform_game_matches_list.dart';

import '../../enums/platforms_id.enum.dart';

class OrganismPlatformGameMatches extends StatelessWidget {

  final PlatformId platform;
  final String gameId;
  
  const OrganismPlatformGameMatches({super.key, required this.platform, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlatformGameMatchesBloc, PlatformGameMatchesState>(
      builder: (context, state) {
        switch (state.status) {
          case ListStatus.initial:
            return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
          
          case ListStatus.success:
            // Message when there is no notification
            if(state.gameMatches.isEmpty) return SizedBox(height: 200, child: Center(child: Text(t.MATCHES.ERRORS.NO_MATCHES)));
            return MoleculePlatformGameMatchesList(
              platform: platform,
              gameId: gameId,
            );
          
          case ListStatus.failure:
            if(state.gameMatches.isEmpty) return SizedBox(height: 200, child: Center(child: Text(t.MATCHES.ERRORS.LOADING_ERROR)));
            return MoleculePlatformGameMatchesList(
              platform: platform,
              gameId: gameId,
            );
        }
      },
    );
  }
}