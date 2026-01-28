part of 'matches_bloc.dart';

class MatchesState extends Equatable {

  final List<LoadedMatches> matchesState;
  final MatchesFilterType selectedType;
  final int lastUpdate;

  const MatchesState({
    this.matchesState = const [],
    this.selectedType = MatchesFilterType.all,
    this.lastUpdate = 0
  });
  
  MatchesState copyWith({
    List<LoadedMatches>? matchesState,
    MatchesFilterType? selectedType,
    int? lastUpdate
  }) {
    return MatchesState (
      matchesState: matchesState ?? this.matchesState,
      selectedType: selectedType ?? this.selectedType,
      lastUpdate: lastUpdate ?? this.lastUpdate
    );
  }
  
  @override
  List<Object> get props => [matchesState, selectedType, lastUpdate];
}


final class PlayerMatchesInitial extends MatchesState {}

class LoadedMatches extends Equatable {
  final MatchesFilterType type;
  final bool hasReachesMax;
  final BlocStatus status;
  final List<MatchWithGame> matches;

  const LoadedMatches({
    required this.type,
    this.hasReachesMax = false,
    this.status = BlocStatus.initial,
    this.matches = const [],
  });

  LoadedMatches copyWith({
    bool? hasReachesMax,
    BlocStatus? status,
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