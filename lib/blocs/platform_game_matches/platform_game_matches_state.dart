part of 'platform_game_matches_bloc.dart';

class PlatformGameMatchesState extends Equatable {

  final List<MinimalMatch> gameMatches;
  final bool hasReachedMax;
  final ListStatus status;

  const PlatformGameMatchesState({
    this.gameMatches = const <MinimalMatch>[],
    this.hasReachedMax = false,
    this.status = ListStatus.initial
  });

  PlatformGameMatchesState copyWith({
    List<MinimalMatch>? gameMatches,
    bool? hasReachedMax,
    ListStatus? status
  }){
    return PlatformGameMatchesState(
      gameMatches: gameMatches ?? this.gameMatches,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status
    );
  }
  
  @override
  List<Object> get props => [gameMatches, hasReachedMax, status];
}
