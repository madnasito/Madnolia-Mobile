import 'package:madnolia/models/match/match_with_game_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';

import '../services/user_service.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/match_card_widget.dart';

class InvitationsPage extends StatelessWidget {
  const InvitationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body:SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Text(translate("NOTIFICATIONS.INVITATIONS"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: "Cyberverse",
                      fontSize: 30,
                      color: Colors.greenAccent),
                ),
              ),
              FutureBuilder(
                future: UserService().getInvitations(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {

                    final matches =
                        snapshot.data.map((e) => MatchWithGame.fromJson(e)).toList();
                    if (matches.isEmpty) {
                      return const Center(child: Text("Empty"));
                    }
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
        ),
    );
  }
}
