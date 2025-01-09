part of 'platform_games_cubit.dart';

class PlatformGamesState extends Equatable {

  final List<PlatformGamesModel> data;
  final int lastUpdate;

  const PlatformGamesState({this.data = const [], this.lastUpdate = 0});

  PlatformGamesState copyWith({
    List<PlatformGamesModel>? data,
    int? lastUpdate
  }) => PlatformGamesState(
    data: data ?? this.data,
    lastUpdate: lastUpdate ?? this.lastUpdate
  );

  @override
  List<Object> get props => [data, lastUpdate];
}

// final class PlatformGamesInitial extends PlatformGamesState {}
