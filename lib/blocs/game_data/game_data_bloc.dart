import 'package:madnolia/models/game/game_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_data_event.dart';
part 'game_data_state.dart';

class GameDataBloc extends Bloc<GameDataEvent, GameDataState> {
  GameDataBloc() : super(const GameDataState()) {
    on<GameDataEvent>((event, emit) {
      if(event is UpdateGameData){
        final Game game = event.game;
        emit(
          state.copyWith(
            id: game.id,
            background: game.background,
            description: game.description,
            gameId: game.gameId,
            name: game.name,
            screenshots: game.screenshots,
            slug: game.slug
          )
        );
      }

      if(event is CleanGameData){
        emit(
          const GameDataState()
        );
      }
    });
  }

  void updateGame(Game game){
    add(UpdateGameData(game: game));
  }

  void cleanData(){
    add(CleanGameData());
  }
}
