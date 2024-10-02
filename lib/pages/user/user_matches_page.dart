import 'package:Madnolia/models/match/match_with_game_model.dart';
import 'package:Madnolia/models/match/minimal_match_model.dart';
import 'package:Madnolia/services/match_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:Madnolia/services/user_service.dart';
import 'package:Madnolia/widgets/background.dart';
import 'package:Madnolia/widgets/custom_scaffold.dart';
import 'package:Madnolia/widgets/match_card_widget.dart';

class UserMatchesPage extends StatelessWidget {
  const UserMatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List<Widget> matchesWidgets = [];

    
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
                  translate("PROFILE.MATCHES_PAGE.TITLE"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: "Cyberverse",
                      fontSize: 30,
                      color: Colors.white),
                ),
              ),
              FutureBuilder(
                future: MatchService().getUserMatches(),
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
        ),
      ),
    ));
  }
}
