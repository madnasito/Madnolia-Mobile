import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/models/match/full_match.model.dart';
import 'package:madnolia/services/match_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/views/view_match.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final extraInfo = GoRouterState.of(context).extra!;
    final service = FlutterBackgroundService();
    service.invoke("look");
    return CustomScaffold(
      body: FutureBuilder(
          future: MatchService().getFullMatch(extraInfo.toString()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {

            if (snapshot.hasData) {

              if (snapshot.data.containsKey("match")) {
                final FullMatch match = FullMatch.fromJson(snapshot.data["match"]);

                // final socketBloc = context.watch<SocketsBloc>();
                return ViewMatch(match: match);
              } else {
                return const Center(child: Text("Error loading match."));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        
      ),
    );
  }
}
