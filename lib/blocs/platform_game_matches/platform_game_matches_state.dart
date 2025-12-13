part of 'platform_game_matches_bloc.dart';

class PlatformGameMatchesState extends Equatable {

  final List<MinimalMatch> gameMatches;

  const PlatformGameMatchesState({this.gameMatches = const <MinimalMatch>[]});

  PlatformGameMatchesState copyWith({
    List<MinimalMatch>? gameMatches,
  }){
    return PlatformGameMatchesState(
      gameMatches: gameMatches ?? this.gameMatches,
    );
  }
  
  @override
  List<Object> get props => [gameMatches];
}
