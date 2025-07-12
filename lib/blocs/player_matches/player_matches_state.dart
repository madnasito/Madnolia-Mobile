part of 'player_matches_bloc.dart';

class PlayerMatchesState extends Equatable {

  final List<LoadedMatches> matchesState;

  const PlayerMatchesState({
    this.matchesState = const []
  });
  
  PlayerMatchesState copyWith({
    List<LoadedMatches>? matchesState
  }) {
    return PlayerMatchesState (
      matchesState: matchesState ?? this.matchesState
    );
  }
  
  @override
  List<Object> get props => [matchesState];
}


final class PlayerMatchesInitial extends PlayerMatchesState {}

class LoadedMatches {
  MatchesFilterType type;
  bool hasReachesMax;
  ListStatus status;
  List<MatchWithGame> matches;

  LoadedMatches({
    required this.type,
    this.hasReachesMax = false,
    this.status = ListStatus.initial,
    this.matches = const []
  });
}


