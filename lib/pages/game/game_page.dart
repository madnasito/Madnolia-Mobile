import 'package:madnolia/database/database.dart';
import 'package:madnolia/database/games/games.repository.dart';
import 'package:madnolia/models/match/minimal_match_model.dart';
import 'package:madnolia/services/match_service.dart';
import 'package:madnolia/widgets/atoms/media/game_image_atom.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import 'package:madnolia/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';

import '../../utils/platforms.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    if(GoRouterState.of(context).extra == null) context.go("/home-user");
    final Map data = GoRouterState.of(context).extra as Map;

    final String game = data["game"];
    final int platform = data["platform"];

    // final gameDataBloc = context.watch<GameDataBloc>();

    return CustomScaffold(
        body:  
            SingleChildScrollView(
              child: Column(
                  children:[ 
                    FutureBuilder(
                      future: GamesRepository().getGameById(game), 
                      builder: (BuildContext context, AsyncSnapshot<GameData> snapshot) {
                        if(snapshot.hasData){
                          final GameData game = snapshot.data!;
                          return  Column(
                              children: [
                                AtomGameImage(name: game.name, background: game.background),
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
                            .push("/match/${matches[index].id}"),
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(matches[index].title, style: const TextStyle(fontSize: 20, overflow: TextOverflow.fade),),
                            SvgPicture.asset(
                              getPlatformInfo(platform).path,
                              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                              width: 60,
                            )
                          ],
                        ),
                        shape: const CircleBorder(),
                        subtitle: matches[index].date > DateTime.now().millisecondsSinceEpoch ?
                        Text(
                          DateTime.fromMillisecondsSinceEpoch(
                                  matches[index].date)
                              .toString()
                              .substring(0, 16),
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Color.fromARGB(255, 176, 229, 255)),
                        ) :
                        const Text("Currently running!", 
                        style: TextStyle(color: Color.fromARGB(255, 142, 255, 236), fontSize: 17), textAlign: TextAlign.center,)
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
  
}
