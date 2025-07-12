import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:madnolia/enums/list_status.enum.dart';
import 'package:madnolia/models/match/match_with_game_model.dart';
import 'package:madnolia/models/match/matches-filter.model.dart';
import 'package:madnolia/services/match_service.dart';
import 'package:stream_transform/stream_transform.dart';

part 'player_matches_event.dart';
part 'player_matches_state.dart';

const matchesThrottleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PlayerMatchesBloc extends Bloc<PlayerMatchesEvent, PlayerMatchesState> {
  PlayerMatchesBloc() : super(PlayerMatchesInitial()) {

    on<InitialState>(_initState);
    on<FetchMatchesType>(_fetchMatches, transformer: throttleDroppable(matchesThrottleDuration)); 

  }

  _initState(InitialState event, Emitter<PlayerMatchesState> emit) {
    final mainList = [
      LoadedMatches(type: MatchesFilterType.all),
      LoadedMatches(type: MatchesFilterType.created),
      LoadedMatches(type: MatchesFilterType.joined),
    ];

    emit(
      state.copyWith(
        matchesState: mainList
      )
    );
  }

  Future _fetchMatches(FetchMatchesType event, Emitter<PlayerMatchesState> emit) async {

    final int index = state.matchesState.indexWhere((e) => e.type == event.filter.type);

    LoadedMatches matchesState = state.matchesState[index];

    try {
      

      if(matchesState.hasReachesMax) return;

      final data = await MatchService().getMatches(event.filter);

      if(data.isEmpty) {
        matchesState.hasReachesMax = true;
        state.matchesState[index] = matchesState;
        return emit(
          state.copyWith(
            matchesState: state.matchesState
          )
        );
      }

      matchesState.matches.addAll(data);
      matchesState.status = ListStatus.success;

      state.matchesState[index] = matchesState;
      emit(
        state.copyWith(
          matchesState: state.matchesState
        )
      );

    } catch (e) {
      matchesState.status = ListStatus.failure;
      state.matchesState[index] = matchesState;
      emit(
        state.copyWith(
          matchesState: state.matchesState
        )
      );
      rethrow;  
    }
  }
}
