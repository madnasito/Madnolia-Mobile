part of 'game_data_bloc.dart';

sealed class GameDataEvent extends Equatable {
  const GameDataEvent();

  @override
  List<Object> get props => [];
}

class UpdateGameData extends GameDataEvent {
  final Game game;
  const UpdateGameData({required this.game});

}

class CleanGameData extends GameDataEvent {}