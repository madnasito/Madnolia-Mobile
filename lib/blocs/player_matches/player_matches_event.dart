part of 'player_matches_bloc.dart';

sealed class PlayerMatchesEvent extends Equatable {
  const PlayerMatchesEvent();

  @override
  List<Object> get props => [];
}

class RestoreState extends PlayerMatchesEvent {}

class InitialState extends PlayerMatchesEvent {}

class UpdateFilterType extends PlayerMatchesEvent {
  final MatchesFilterType type;

  const UpdateFilterType({required this.type});
}

class FetchMatchesType extends PlayerMatchesEvent {
  final MatchesFilter filter;
  const FetchMatchesType({required this.filter});
}
