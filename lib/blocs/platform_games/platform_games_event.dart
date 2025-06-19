part of 'platform_games_bloc.dart';

sealed class PlatformGamesEvent extends Equatable {
  const PlatformGamesEvent();

  @override
  List<Object> get props => [];
}

final class RestoreState extends PlatformGamesEvent {}

final class LoadPlatforms extends PlatformGamesEvent {
  final List<int> platforms;
  const LoadPlatforms({required this.platforms});
}

class PlatformGamesFetched extends PlatformGamesEvent {
  final int platformId;

  const PlatformGamesFetched({required this.platformId});
}
