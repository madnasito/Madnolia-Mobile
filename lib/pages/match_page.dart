import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:Madnolia/blocs/message_provider.dart';
import 'package:Madnolia/views/match_view.dart';
import 'package:Madnolia/widgets/background.dart';
import 'package:Madnolia/widgets/custom_scaffold.dart';

import 'package:Madnolia/models/match_model.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Match extraMatch = GoRouterState.of(context).extra! as Match;
    final bloc = MessageProvider.of(context);

    return CustomScaffold(
      body: Background(
        child: SafeArea(
            child:
                //  MatchOwnerView(
                //   match: extraMatch,
                // ),
                MatchChat(
          match: extraMatch,
          bloc: bloc,
        )),
      ),
    );
  }
}
