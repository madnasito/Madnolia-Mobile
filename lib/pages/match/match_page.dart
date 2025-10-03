import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/database/match/match.services.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/widgets/scaffolds/custom_scaffold.dart';
import 'package:madnolia/widgets/views/view_match.dart';

class MatchPage extends StatelessWidget {
  final String id;

  const MatchPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: FutureBuilder(
          future: MatchDbServices().getMatchWithGame(id),
          builder: (BuildContext context, AsyncSnapshot<MatchWithGame> snapshot) {

            if (snapshot.hasData) {

              return ViewMatch(match: snapshot.data!.match, game: snapshot.data!.game,);
              
            } else if(snapshot.hasError){
              return Center(child: Text(translate("MATCH.ERROR_LOADING")));
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        
      ),
    );
  }
}
