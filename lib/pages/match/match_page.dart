import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/models/match/full_match.model.dart';
import 'package:madnolia/services/match_service.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/views/view_match.dart';

class MatchPage extends StatelessWidget {

  final String id;

  const MatchPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final service = FlutterBackgroundService();
    service.invoke("look");
    return CustomScaffold(
      body: FutureBuilder(
          future: MatchService().getFullMatch(id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {

            if (snapshot.hasData) {

              if (snapshot.data.containsKey("match")) {
                final FullMatch match = FullMatch.fromJson(snapshot.data["match"]);

                // final socketBloc = context.watch<SocketsBloc>();
                return ViewMatch(match: match);
              } else {
                return Center(child: Text(translate("MATCH.ERROR_LOADING")));
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        
      ),
    );
  }
}
