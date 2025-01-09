import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/models/game/home_game_model.dart';
import 'package:madnolia/models/platform/platform_games_model.dart';

part 'platform_games_state.dart';

class PlatformGamesCubit extends Cubit<PlatformGamesState> {
  PlatformGamesCubit() : super(const PlatformGamesState());

  void cleanData () => emit(state.copyWith(data: []));

  void addPlatformAndGames(PlatformGamesModel data){
    List<PlatformGamesModel> platformGames = [];
    platformGames.add(data);
    platformGames.addAll(state.data);
    emit(state.copyWith(data: platformGames, lastUpdate: DateTime.now().millisecondsSinceEpoch));
  }


  void addGamesToPlatform(int platform, List<HomeGame> games){
    try {
      PlatformGamesModel objetive = state.data.firstWhere((element) => element.platform == platform);
      objetive.games.addAll(games);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  PlatformGamesModel getPlatformGames(int platform) => state.data.firstWhere((element) => element.platform == platform, orElse: () => PlatformGamesModel(platform: 0, games: []));
}
