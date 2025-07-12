part of 'player_matches_bloc.dart';

class PlayerMatchesState extends Equatable {

  final List<LoadedMatches> matchesState;
  final MatchesFilterType selectedType;

  const PlayerMatchesState({
    this.matchesState = const [],
    this.selectedType = MatchesFilterType.all
  });
  
  PlayerMatchesState copyWith({
    List<LoadedMatches>? matchesState,
    MatchesFilterType? selectedType
  }) {
    return PlayerMatchesState (
      matchesState: matchesState ?? this.matchesState,
      selectedType: selectedType ?? this.selectedType
    );
  }
  
  @override
  List<Object> get props => [matchesState, selectedType];
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


