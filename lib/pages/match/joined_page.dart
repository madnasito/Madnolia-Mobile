import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/models/match/match_with_game_model.dart';
import 'package:madnolia/services/match_service.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/molecules/molecule_matches_list.dart';

class JoinedPage extends StatelessWidget {
  const JoinedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: Text(
                translate("HEADER.JOINED_MATCHES"),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: "Cyberverse",
                    fontSize: 30,
                    color: Colors.white),
              ),
            ),
            FutureBuilder(
              future: MatchService().getJoinedMatches(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List list = snapshot.data;
    
                  final matches =
                      list.map<MatchWithGame>((e) => MatchWithGame.fromJson(e)).toList();
                  
                  return MoleculeMatchesList(matches: matches);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      )
    );
  }
}