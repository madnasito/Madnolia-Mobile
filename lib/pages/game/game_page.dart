import 'package:Madnolia/models/match/match_model.dart';
import 'package:Madnolia/services/games_service.dart';
import 'package:Madnolia/widgets/match_card_widget.dart';
import 'package:flutter/material.dart';

import 'package:Madnolia/widgets/custom_scaffold.dart';
import 'package:Madnolia/widgets/background.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../models/game_model.dart';
import '../../utils/platform_id_ico.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map data = GoRouterState.of(context).extra as Map;

    final Game game = data["game"] as Game;

    final String platformPath =
        "assets/platforms/${data['platform_category'].toString().toLowerCase()}.svg";

    return CustomScaffold(
        body: Background(
      child: SafeArea(
        child: Column(
          children: [
            GameCard(
              game: game,
              bottom: Text(""),
            ),
            Wrap(
              spacing: 10,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SvgPicture.asset(
                  platformPath,
                  width: 50,
                  // ignore: deprecated_member_use
                  color: Colors.white,
                ),
                Text(getPlatformInfo(data["platform"]).name)
              ],
            ),
            FutureBuilder(
              future: _loadInfo(game.id, data["platform"]),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  final matches =
                      snapshot.data.map((e) => Match.fromJson(e)).toList();

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: matches.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: ListTile(
                          onTap: () => GoRouter.of(context)
                              .push("/match", extra: matches[index]),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(matches[index].message),
                              // Text(
                              //   game.name,
                              //   style: TextStyle(overflow: TextOverflow.fade),
                              // ),
                              SvgPicture.asset(
                                getPlatformInfo(data["platform"]).path,
                                // ignore: deprecated_member_use
                                color: Colors.white,
                                width: 60,
                              )
                            ],
                          ),
                          shape: CircleBorder(),
                          subtitle: Text(
                            DateTime.fromMillisecondsSinceEpoch(
                                    matches[index].date)
                                .toString()
                                .substring(0, 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    ));
  }

  _loadInfo(int gameId, int platformId) async {
    final info =
        await GamesService().getPlatformGameMatches(platformId, gameId);

    return info;
  }
}
