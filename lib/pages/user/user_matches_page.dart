import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/services/user_service.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/models/match_model.dart';
import 'package:madnolia/widgets/match_card_widget.dart';

class UserMatchesPage extends StatelessWidget {
  const UserMatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> matchesWidgets = [];
    return CustomScaffold(
        body: Background(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: const Text(
                  "My matches",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Cyberverse",
                      fontSize: 30,
                      color: Colors.greenAccent),
                ),
              ),
              FutureBuilder(
                future: UserService().getUserMatches(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List matches = snapshot.data["matches"];

                    final list = matches.map((e) => Match.fromJson(e)).toList();
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              context.go('/match', extra: list[index]);
                            },
                            child: MatchCard(
                                match: list[index],
                                bottom: Column(
                                  children: [
                                    Text(list[index].message),
                                    Text(DateTime.fromMillisecondsSinceEpoch(
                                            list[index].date)
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
