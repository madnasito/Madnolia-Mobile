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

    on<FetchMatchesType>(_fetchMatches, transformer: throttleDroppable(matchesThrottleDuration)); 
    on<InitialState>(_initState);
    on<UpdateFilterType>(_updateFilterType);
    on<RestoreMatchesState>(_restoreState);

  }

  _initState(InitialState event, Emitter<PlayerMatchesState> emit) {
    final mainList = [
      LoadedMatches(type: MatchesFilterType.all, hasReachesMax: false, matches: [], status: ListStatus.initial),
      LoadedMatches(type: MatchesFilterType.created, hasReachesMax: false, matches: [], status: ListStatus.initial),
      LoadedMatches(type: MatchesFilterType.joined, hasReachesMax: false, matches: [], status: ListStatus.initial),
    ];

    emit(
      state.copyWith(
        matchesState: mainList,
        selectedType: MatchesFilterType.all,
      )
    );
  }

  void _restoreState(RestoreMatchesState event, Emitter<PlayerMatchesState> emit){
    emit(
      state.copyWith(
        lastUpdate: 0,
        matchesState: [],
        selectedType: MatchesFilterType.all
      )
    );
  }
  void _updateFilterType(UpdateFilterType event, Emitter<PlayerMatchesState> emit) {
  // First emit the new selected type
  emit(state.copyWith(selectedType: event.type));

  // Find the matching matches state or create a new one if not found
  final index = state.matchesState.indexWhere((e) => e.type == event.type);
  final matchesState = index != -1 
      ? state.matchesState[index]
      : LoadedMatches(
          type: event.type,
          matches: [],
          status: ListStatus.initial,
          hasReachesMax: false,
        );

  // If we need to fetch data (either new state or empty existing state)
  if (matchesState.status != ListStatus.success || matchesState.matches.isEmpty) {
    add(FetchMatchesType(
      filter: MatchesFilter(
        skip: matchesState.matches.length,
        sort: SortType.asc,
        type: event.type,
        platform: null,
      ),
    ));
  }

    // If we created a new matchesState, add it to the list
    if (index == -1) {
      emit(state.copyWith(
        matchesState: [...state.matchesState, matchesState],
      ));
    }
  }

  Future _fetchMatches(FetchMatchesType event, Emitter<PlayerMatchesState> emit) async {

    final int index = state.matchesState.indexWhere((e) => e.type == event.filter.type);
    // Create a new copy of the matchesState to modify
      final currentMatchesState = state.matchesState[index];

      

    try {
      

      if(currentMatchesState.hasReachesMax) return;

      final data = await MatchService().getMatches(event.filter);

      final updatedMatchesState = LoadedMatches(
        type: currentMatchesState.type,
        hasReachesMax: data.isEmpty, // o currentMatchesState.hasReachesMax || data.isEmpty
        status: ListStatus.success,
        matches: [
          ...currentMatchesState.matches,
          ...data,
        ],
      );

      final List<LoadedMatches> updatedList = [
        for (var item in state.matchesState)
          if (item.type == event.filter.type) updatedMatchesState else item,
      ];

      emit(state.copyWith(
        matchesState: updatedList,
        lastUpdate: DateTime.now().millisecondsSinceEpoch
        )
      );

      // matchesState.copyWith(status: ListStatus.success);
      // if(data.isEmpty) {
      //   matchesState.copyWith(hasReachesMax: true);
      //   state.matchesState[index] = matchesState;
      //   return emit(
      //     state.copyWith(
      //       matchesState: state.matchesState,
      //     )
      //   );
      // }

      // matchesState.matches.addAll(data);

      // state.matchesState[index] = matchesState;
      // emit(
      //   state.copyWith(
      //     matchesState: state.matchesState
      //   )
      // );

    } catch (e) {
      currentMatchesState.copyWith(status: ListStatus.failure);
      state.matchesState[index] = currentMatchesState;
      emit(
        state.copyWith(
          matchesState: state.matchesState,
          lastUpdate: DateTime.now().millisecondsSinceEpoch
        )
      );
      rethrow;  
    }
  }
}
