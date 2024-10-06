part of 'home_games_bloc.dart';

class HomeGamesState extends Equatable {

  final List<HomeGames> homeGames;

  const HomeGamesState({this.homeGames = const []});

  HomeGamesState copyWith({
    List<HomeGames>? homeGames
  }) => HomeGamesState(
    homeGames: homeGames ?? this.homeGames
  );
  
  @override
  List<Object> get props => [homeGames];
}

