import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/cubits/cubits.dart';
import 'package:madnolia/models/platform/platform_games_model.dart';

import '../../models/game/home_game_model.dart';
import '../../services/match_service.dart';
import '../match_card_widget.dart';

class MoleculePlatformMatches extends StatelessWidget {

  final int platform;

  const MoleculePlatformMatches({required this.platform, super.key});


  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: _loadGames(platform, context),
      builder: (BuildContext context, AsyncSnapshot<List<HomeGame>> snapshot) { 
        if(snapshot.hasData){

          if(snapshot.data!.isNotEmpty){
            return CarouselSlider.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {  
                final HomeGame game = snapshot.data![index];
                return GestureDetector(
                  onTap: (){
                    GoRouter.of(context)
                      .push("/game", extra: {
                        "platform": platform,
                        "game": snapshot.data![index].id
                      });
                  },
                  child: GameCard(
                    name: game.name,
                    background: game.background,
                    bottom: Text(_getMatchesTranslation(game.count))
                  ),
                );
              },
              options: CarouselOptions(
                aspectRatio: 1.262,
                enlargeFactor: 0.1,
                viewportFraction: 0.9,
                disableCenter: true,
                enlargeCenterPage: true
                ),
              disableGesture: true,
            );
            
          }else{
            return Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: double.maxFinite,
                color: Colors.black,
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  crossAxisAlignment:
                      WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  spacing: 10,
                  direction: Axis.vertical,
                  children: [
                    Text(
                      "${translate("HOME.NO_MATCHES")} ",
                      style:
                          const TextStyle(color: Colors.grey),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          GoRouter.of(context).push(
                              "/search_game",
                              extra: platform),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        shadowColor: Colors.black,
                        side: const BorderSide(
                            color: Colors.blue, width: 3),
                        backgroundColor: Colors.black,
                        shape: const StadiumBorder(),
                      ),
                      child: Text(translate("HOME.CREATE")),
                    )
                  ],
                )
              );
          }
        }else{
          return const CircularProgressIndicator();
        }
      },
    );
    
  }
  String _getMatchesTranslation(int amount){
      if(amount == 0) {
        return translate('HOME.NO_MATCHES');
      } else if(amount == 1) {return "$amount ${translate('HOME.MATCH')}";}

      else {return "$amount ${translate('HOME.MATCHES')}";}
    }
}

Future<List<HomeGame>> _loadGames(int platformId, BuildContext context) async {
    try {
      final platformGamesCubit = context.watch<PlatformGamesCubit>();

      final loadedGames = platformGamesCubit.getPlatformGames(platformId);

      DateTime checkUpdateTime = DateTime.fromMillisecondsSinceEpoch(platformGamesCubit.state.lastUpdate).add(const Duration(minutes: 4));

      if(loadedGames.platform == 0 || (checkUpdateTime.millisecondsSinceEpoch < DateTime.now().millisecondsSinceEpoch)){
        final resp = await MatchService().getMatchesByPlatform(platformId);
        final values =
            resp.map((e) => HomeGame.fromJson(e)).toList();
        platformGamesCubit.addPlatformAndGames(PlatformGamesModel(platform: platformId, games: values));
        return values;
      }else{
        return loadedGames.games;
      }

    } catch (e) {
      return [];
    }
}