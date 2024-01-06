import 'package:Madnolia/services/match_service.dart';
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
    final extraInfo = GoRouterState.of(context).extra!;
    final bloc = MessageProvider.of(context);
    return CustomScaffold(
      body: Background(
        child: SafeArea(
            child: extraInfo is Match
                ? MatchChat(
                    match: extraInfo,
                    bloc: bloc,
                  )
                : FutureBuilder(
                    future: MatchService().getMatch(extraInfo.toString()),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data["ok"]) {
                          snapshot.data["match"]["users"] = [];
                          final match = Match.fromJson(snapshot.data["match"]);

                          return MatchChat(match: match, bloc: bloc);
                        } else {
                          return Center(child: Text("Error loading match."));
                        }
                      } else {
                        return Center(child: const CircularProgressIndicator());
                      }
                    },
                  )),
      ),
    );
  }
}
