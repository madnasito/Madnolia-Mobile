import 'package:madnolia/blocs/game_data/game_data_bloc.dart';
import 'package:madnolia/models/game/game_model.dart';
import 'package:madnolia/models/match/minimal_match_model.dart';
import 'package:madnolia/services/games_service.dart';
import 'package:madnolia/services/match_service.dart';
import 'package:madnolia/widgets/atoms/game_image_atom.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';

import '../../utils/platform_id_ico.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    if(GoRouterState.of(context).extra == null) context.go("/home-user");
    final Map data = GoRouterState.of(context).extra as Map;

    final String game = data["game"];
    final int platform = data["platform"];

    final gameDataBloc = context.watch<GameDataBloc>();

    return CustomScaffold(
        body: Background(
      child: SafeArea(
        child: 
            SingleChildScrollView(
              child: Column(
                  children:[ 
                    FutureBuilder(
                      future: _loadGameInfo(game, gameDataBloc), 
                      builder: (BuildContext context, AsyncSnapshot<Game> snapshot) {
                        if(snapshot.hasData){
                          final Game game = snapshot.data!;
                          return  Column(
                              children: [
                                GameImageAtom(name: game.name, background: game.background),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                      Colors.black12,
                                      Colors.black26,
                                      Colors.black,
                                      Colors.black26,
                                      Colors.black12
                                    ])
                                  ),
                                  child: ExpandableText(
                                    game.description,
                                    expandText: translate("UTILS.SHOW_MORE"),
                                    collapseText: translate("UTILS.SHOW_LESS"),
                                    maxLines: 6,
                                    animation: true,
                                    collapseOnTextTap: true,
                                    expandOnTextTap: true,
                                    urlStyle: const TextStyle(
                                      color: Color.fromARGB(255, 169, 145, 255)
                                    ),
                                    ),
                                ),
                                Text(getPlatformInfo(platform).name),
                              ],
                            );
                        }else{
                          return const Center(child: CircularProgressIndicator());
                        }
                      }
                    ),
                    FutureBuilder(
                      future: _loadMatches(game, platform),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return _matchesList(snapshot.data, platform);
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
            ),
            ),
      ),
    );

    
  }

  ListView _matchesList(List<MinimalMatch> matches, int platform) {
    return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: matches.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          border: Border.all(color: Colors.blue, width: 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: ListTile(
                        onTap: () => GoRouter.of(context)
                            .push("/match", extra: matches[index].id),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(matches[index].title),
                            SvgPicture.asset(
                              getPlatformInfo(platform).path,
                              // ignore: deprecated_member_use
                              color: Colors.white,
                              width: 60,
                            )
                          ],
                        ),
                        shape: const CircleBorder(),
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
  }

  Future<List<MinimalMatch>> _loadMatches(String game, int platform) async {
    final List info =
        await MatchService().getMatchesByPlatformAndGame(platform, game);

    final List<MinimalMatch> matches = info.map((e) => MinimalMatch.fromJson(e)).toList();
    return matches;
  }
  
  Future<Game> _loadGameInfo(String game, GameDataBloc gameDataBloc) async {

    if(gameDataBloc.state.id == game){
      final gameData = gameDataBloc.state;
      return Game(
        id: gameData.id,
        name: gameData.name,
        slug: gameData.slug,
        gameId: gameData.gameId,
        background: gameData.background,
        screenshots: gameData.screenshots,
        description: gameData.description
      );
    }

    final respData = await GamesService().getGameInfo(game);

    final Game gameData = Game.fromJson(respData);

    gameDataBloc.updateGame(gameData);

    return gameData;
  }
}
