part of 'matches_bloc.dart';

sealed class MatchesEvent extends Equatable {
  const MatchesEvent();

  @override
  List<Object> get props => [];
}

class RestoreMatchesState extends MatchesEvent {}

class InitialState extends MatchesEvent {}

class UpdateFilterType extends MatchesEvent {
  final MatchesFilterType type;

  const UpdateFilterType({required this.type});
}

class FetchMatchesType extends MatchesEvent {
  final MatchesFilter filter;
  const FetchMatchesType({required this.filter});
}
