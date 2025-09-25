import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/widgets/atoms/input/atom_search_input.dart';
import 'package:madnolia/widgets/scaffolds/custom_scaffold.dart';
import 'package:madnolia/widgets/molecules/lists/games_list_molecule.dart';

import '../../models/game/minimal_game_model.dart';
import '../../widgets/match_card_widget.dart';
import '../../services/games_service.dart';

class SearchGamePage extends StatefulWidget {
  const SearchGamePage({super.key});

  @override
  State<SearchGamePage> createState() => _SearchGamePageState();
}


class _SearchGamePageState extends State<SearchGamePage> {
  late int counter;
  late TextEditingController controller;
  @override
  void initState() {
    counter = 0;
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    counter = 0;
    // game = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
  if(GoRouterState.of(context).extra == null) context.go("/new");

    int platformId = GoRouterState.of(context).extra as int;
    return CustomScaffold(
      body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AtomSearchInput(
                  searchController: controller,
                  placeholder:
                      translate("CREATE_MATCH.SEARCH_GAME"),
                  onChanged: (value) async {
                    debugPrint(controller.text);
                    counter++;
                    Timer(
                      const Duration(seconds: 1),
                      () {
                        counter--;
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              (controller.text.isEmpty) ? FutureBuilder(
                future: GamesService.getRecomendations(platformId),
                builder: (BuildContext context, AsyncSnapshot<List<MinimalGame>> snapshot) {
                  if(!snapshot.hasData){
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [Text(translate('CREATE_MATCH.LOADING_RECOMENDATIONS')), CircularProgressIndicator()],),
                    );
                  }else if(snapshot.data!.isNotEmpty){
                    return Expanded(
                      child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(translate("RECOMMENDATIONS.FOR_YOU"), style: TextStyle(fontSize: 15),),
                        const SizedBox(height: 20),
                        Flexible(child: GamesListMolecule(
                          games: snapshot.data!,
                          platform: platformId)
                        ),
                      ],
                    )
                    );
                  } else if(snapshot.data!.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(translate('RECOMMENDATIONS.EMPTY'),
                          textAlign: TextAlign.center
                          )
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }
              ) : Container(),
              (counter == 0 && controller.text.isNotEmpty)
                  ? FutureBuilder(
                      future: GamesService.getGames(
                          title: controller.text.toString(),
                          platform: "$platformId"),
                      builder:
                          (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          return Flexible(
                              child: snapshot.data.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () => setState(() {
                                            context.push("/new/match", extra: {
                                              "game": snapshot.data[index],
                                              "platformId": platformId
                                            });
                                          }),
                                          child:  GameCard(
                                              background: snapshot.data[index].backgroundImage,
                                              name: snapshot.data[index].name,
                                              bottom: const Text("")),
                                        );
                                      })
                              : (controller.text.length > 3) ? 
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(translate("CREATE_MATCH.EMPTY_SEARCH"), textAlign: TextAlign.center,)
                              ) : 
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(translate('CREATE_MATCH.SEARCH_HINT'), textAlign: TextAlign.center,)
                              )
                            );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    )
                  : const Text(""),
            ],
          ),
      
    );
  }
}