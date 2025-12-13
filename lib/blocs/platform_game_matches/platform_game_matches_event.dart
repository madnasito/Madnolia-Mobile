part of 'platform_game_matches_bloc.dart';

sealed class PlatformGameMatchesEvent extends Equatable {
  const PlatformGameMatchesEvent();

  @override
  List<Object> get props => [];
}


final class LoadPlatformGameMatches extends PlatformGameMatchesEvent {
  final PlatformId platformId;
  final String gameId;

  const LoadPlatformGameMatches({required this.platformId, required this.gameId});
}

final class RestorePlatformGameMatches extends PlatformGameMatchesEvent {}