part of 'player_matches_bloc.dart';

class PlayerMatchesState extends Equatable {

  final List<LoadedMatches> matchesState;
  final MatchesFilterType selectedType;
  final int lastUpdate;

  const PlayerMatchesState({
    this.matchesState = const [],
    this.selectedType = MatchesFilterType.all,
    this.lastUpdate = 0
  });
  
  PlayerMatchesState copyWith({
    List<LoadedMatches>? matchesState,
    MatchesFilterType? selectedType,
    int? lastUpdate
  }) {
    return PlayerMatchesState (
      matchesState: matchesState ?? this.matchesState,
      selectedType: selectedType ?? this.selectedType,
      lastUpdate: lastUpdate ?? this.lastUpdate
    );
  }
  
  @override
  List<Object> get props => [matchesState, selectedType, lastUpdate];
}


final class PlayerMatchesInitial extends PlayerMatchesState {}

class LoadedMatches extends Equatable {
  final MatchesFilterType type;
  final bool hasReachesMax;
  final ListStatus status;
  final List<MatchWithGame> matches;

  const LoadedMatches({
    required this.type,
    this.hasReachesMax = false,
    this.status = ListStatus.initial,
    this.matches = const [],
  });

  LoadedMatches copyWith({
    bool? hasReachesMax,
    ListStatus? status,
    List<MatchWithGame>? matches,
  }) {
    return LoadedMatches(
      type: type,
      hasReachesMax: hasReachesMax ?? this.hasReachesMax,
      status: status ?? this.status,
      matches: matches ?? this.matches,
    );
  }

  @override
  List<Object> get props => [type, hasReachesMax, status, matches];
}