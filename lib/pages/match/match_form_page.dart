import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/views/create_match_view.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

import '../../models/game_model.dart';

class MatchFormPage extends StatelessWidget {
  const MatchFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    late var extra = GoRouterState.of(context).extra as Map;

    Game game = extra["game"] as Game;
    return CustomScaffold(
        body:MatchFormView(
        game: game,
        platformId: extra["platformId"],
      ),
    );
  }
}
