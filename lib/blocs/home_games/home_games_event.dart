part of 'home_games_bloc.dart';

sealed class HomeGamesEvent extends Equatable {
  const HomeGamesEvent();

  @override
  List<Object> get props => [];
}

class UpdateGames extends HomeGamesEvent {
  final int platformId;
  final List<HomeGame> homeGames;

  const UpdateGames({required this.platformId, required this.homeGames});

}

