import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' show droppable;
import 'package:equatable/equatable.dart';
import 'package:madnolia/models/platform/platform_games_model.dart';
import 'package:madnolia/services/match_service.dart';
import 'package:stream_transform/stream_transform.dart';

part 'platform_games_event.dart';
part 'platform_games_state.dart';

const throttleDuration = Duration(milliseconds: 100);
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}


class PlatformGamesBloc extends Bloc<PlatformGamesEvent, PlatformGamesState> {
  PlatformGamesBloc() : super(PlatformGamesInitial()) {

    on<LoadPlatforms>(_loadPlatforms);

    on<PlatformGamesFetched>(_onFetchPlatformGames, transformer: throttleDroppable(throttleDuration));
    // on<PlatformGamesFetched>((event, emit) {
    // });

    on<RestoreState>(_restoreState);
  }

  void _loadPlatforms(LoadPlatforms event, Emitter<PlatformGamesState> emit) {
    List<PlatformGamesModel> newUserPlatforms = [];

    for (var id in event.platforms) {
      newUserPlatforms.add(PlatformGamesModel(platform: id, games: [], page: 0, status: PlatformGamesStatus.initial, hasReachedMax: false));
    }

    emit(state.copyWith(platformGames: newUserPlatforms));
  }

  Future _onFetchPlatformGames(PlatformGamesFetched event, Emitter<PlatformGamesState> emit) async {

    List<PlatformGamesModel> platformsGames = state.platformGames;
    PlatformGamesModel? platformState = state.platformGames.firstWhere((e) => e.platform == event.platformId);

    try {
      final games = await MatchService().getGamesMatchesByPlatform(platformId: platformState.platform, page: platformState.page);

      if(games.isEmpty){
        platformState.hasReachedMax = true;
        final index = platformsGames.indexWhere((e) => e.platform == event.platformId);
        platformsGames[index] = platformState;

        return emit(state.copyWith(
          platformGames: platformsGames,
          lastUpdate: DateTime.now().millisecondsSinceEpoch
        ));
      }

      if(games.length < 5) platformState.hasReachedMax = true;

      platformState.games = games;
      platformState.page++;
      platformState.status = PlatformGamesStatus.success;

      final index = platformsGames.indexWhere((e) => e.platform == event.platformId);
      platformsGames[index] = platformState;

      emit(state.copyWith(
        platformGames: platformsGames,
        lastUpdate: DateTime.now().millisecondsSinceEpoch
      ));

    } catch (e) {
      platformState.status = PlatformGamesStatus.failure;
      final index = platformsGames.indexWhere((e) => e.platform == event.platformId);
      platformsGames[index] = platformState;

      emit(state.copyWith(
        platformGames: platformsGames,
        lastUpdate: DateTime.now().millisecondsSinceEpoch
      ));
    }

  }

  void _restoreState(RestoreState event, Emitter<PlatformGamesState> emit){
    emit(state.copyWith(platformGames: [], lastUpdate: 0));
  }
}
