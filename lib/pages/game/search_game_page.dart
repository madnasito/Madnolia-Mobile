import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/widgets/background.dart';
import 'package:madnolia/widgets/custom_input_widget.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/molecules/games_list_molecule.dart';

import '../../models/game/minimal_game_model.dart';
import '../../services/match_service.dart';
import '../../services/rawg_service.dart';

class SearchGamePage extends StatelessWidget {
  const SearchGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    if(GoRouterState.of(context).extra == null) context.go("/new");

    int platformId = GoRouterState.of(context).extra as int;

    TextEditingController controller = TextEditingController();
    int counter = 0;
    return CustomScaffold(
      body: Background(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SimpleCustomInput(
                placeholder: translate("CREATE_MATCH.SEARCH_GAME"),
                controller: controller,
                iconData: CupertinoIcons.search,
                onChanged: (value) async {
                  counter++;
                    Timer(
                      const Duration(seconds: 1),
                      () {
                        counter--;
                      },
                    );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            (controller.text.isEmpty) ? FutureBuilder(
                future: getRecomendations(platformId),
                builder: (BuildContext context, AsyncSnapshot<List<MinimalGame>> snapshot) {
                  if(!snapshot.hasData){
                    return const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [Text('Loading recomendations '), CircularProgressIndicator()],);
                  }else if(snapshot.data!.isNotEmpty){
                    return Expanded(
                      child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Recommendations for you", style: TextStyle(fontSize: 15),),
                        const SizedBox(height: 20),
                        Flexible(child: GamesListMolecule(games: snapshot.data!, platform: platformId,)),
                      ],
                    )
                    );
                  }else {
                    return Container();
                  }
                }
              ) : Container()
          ],
        ),
      ),
    );
  }

  Future getGames({required String title, required String platform}) async {
    return RawgService().searchGame(game: title, platform: platform);
  }

  Future<List<MinimalGame>> getRecomendations(int platform) async {
    final List resp = await MatchService().getGamesRecomendations(platform);

    final games = resp.map((e) => MinimalGame.fromJson(e)).toList();

    return games;
  }
}