part of 'platform_games_bloc.dart';

class PlatformGamesState extends Equatable {

  final List<PlatformGamesModel> platformGames;
  final int lastUpdate;
  const PlatformGamesState({this.platformGames = const <PlatformGamesModel>[], this.lastUpdate = 0});
  
  PlatformGamesState copyWith({
    List<PlatformGamesModel>? platformGames,
    int? lastUpdate
  }){
    return PlatformGamesState(platformGames: platformGames ?? this.platformGames, lastUpdate: lastUpdate ?? this.lastUpdate);
  }

  @override
  List<Object> get props => [platformGames, lastUpdate];
}

final class PlatformGamesInitial extends PlatformGamesState {}
