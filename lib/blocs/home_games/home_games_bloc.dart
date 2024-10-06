import 'package:Madnolia/models/game/home_game_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/molecules/platform_matches_molecule.dart';

part 'home_games_event.dart';
part 'home_games_state.dart';

class HomeGamesBloc extends Bloc<HomeGamesEvent, HomeGamesState> {
  HomeGamesBloc() : super(const HomeGamesState()) {
    on<HomeGamesEvent>((event, emit) {
      if(event is UpdateGames) {
        
      }
    });
  }

  updateGames(int platformId, List<HomeGame> homeGames){
    add(UpdateGames(platformId: platformId, homeGames: homeGames));
  }
}

class HomeGames {
  final int platformId;
  final List<HomeGame> homeGames;

  HomeGames({required this.platformId, required this.homeGames});
}