import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/views/match_view.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

import 'package:madnolia/models/match_model.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Match extraMatch = GoRouterState.of(context).extra! as Match;

    return CustomScaffold(
      body: Background(
        child: SafeArea(
            child:
                //  MatchOwnerView(
                //   match: extraMatch,
                // ),
                MatchChat(match: extraMatch)),
      ),
    );
  }
}
