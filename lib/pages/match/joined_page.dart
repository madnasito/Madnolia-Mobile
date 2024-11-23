import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/match/match_with_game_model.dart';
import 'package:madnolia/services/match_service.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/match_card_widget.dart';

class JoinedPage extends StatelessWidget {
  const JoinedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Background(
        child: SafeArea(
          child: SingleChildScrollView(
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
                          list.map((e) => MatchWithGame.fromJson(e)).toList();
                      
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: matches.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                GoRouter.of(context)
                                    .push('/match', extra: matches[index].id);
                              },
                              child: MatchCard(
                                  match: matches[index],
                                  bottom: Column(
                                    children: [
                                      Text(matches[index].title),
                                      Text(DateTime.fromMillisecondsSinceEpoch(
                                              matches[index].date)
                                          .toString()
                                          .substring(0, 19))
                                    ],
                                  )),
                            );
                          });
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          )
        ),
      )
    );
  }
}