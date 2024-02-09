import 'package:Madnolia/models/match/minimal_match_model.dart';
import 'package:Madnolia/widgets/language_builder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multi_language_json/multi_language_json.dart';

import '../services/user_service.dart';
import '../widgets/background.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/match_card_widget.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LangSupport langData = LanguageBuilder.langData;
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
                  langData.getValue(route: ["NOTIFICATIONS", "INVITATIONS"]),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Cyberverse",
                      fontSize: 30,
                      color: Colors.greenAccent),
                ),
              ),
              FutureBuilder(
                future: UserService().getInvitations(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List matches = snapshot.data["invitations"];

                    List list =
                        matches.map((e) => MinimalMatch.fromJson(e)).toList();
                    if (list.isEmpty) {
                      return Center(child: Text("Empty"));
                    }
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              GoRouter.of(context)
                                  .push('/match', extra: list[index].id);
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
