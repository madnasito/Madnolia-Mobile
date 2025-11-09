import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:madnolia/database/repository_manager.dart';
import 'package:madnolia/enums/list_status.enum.dart';
import 'package:madnolia/models/match/match_with_game_model.dart';
import 'package:madnolia/models/match/matches-filter.model.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../enums/sort_type.enum.dart';

part 'matches_event.dart';
part 'matches_state.dart';

const matchesThrottleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MatchesBloc extends Bloc<MatchesEvent, MatchesState> {

  final _matchRepository = RepositoryManager().match;
  MatchesBloc() : super(PlayerMatchesInitial()) {

    on<LoadMatches>(_loadMatches, transformer: throttleDroppable(matchesThrottleDuration)); 
    on<InitialState>(_initState);
    on<UpdateFilterType>(_updateFilterType);
    on<RestoreMatchesState>(_restoreState);

  }

  void _initState(InitialState event, Emitter<MatchesState> emit) {
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

  void _restoreState(RestoreMatchesState event, Emitter<MatchesState> emit){
    emit(
      state.copyWith(
        lastUpdate: 0,
        matchesState: [],
        selectedType: MatchesFilterType.all
      )
    );
  }
  void _updateFilterType(UpdateFilterType event, Emitter<MatchesState> emit) {
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

  final now = DateTime.now();
  final lastUpdate = DateTime.fromMillisecondsSinceEpoch(state.lastUpdate);

  // If we need to fetch data (either new state or empty existing state)
  if (matchesState.status != ListStatus.success || matchesState.matches.isEmpty || now.difference(lastUpdate).inMinutes < 6) {
    add(LoadMatches(
      filter: MatchesFilter(
        skip: matchesState.matches.length,
        sort: SortType.desc,
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

  Future<void> _loadMatches(LoadMatches event, Emitter<MatchesState> emit) async {
    final int index = state.matchesState.indexWhere((e) => e.type == event.filter.type);
    final currentMatchesState = state.matchesState[index];
    try {
      if (currentMatchesState.hasReachesMax) return;

      final isReload = currentMatchesState.status == ListStatus.initial || event.reload;

      final data = await _matchRepository.getMatchesWithGame(filter: event.filter, reload: isReload);

      bool hasReachedMax = false;

      if(data.length < event.filter.limit) hasReachedMax = true;

      final updatedMatchesState = LoadedMatches(
        type: currentMatchesState.type,
        hasReachesMax: hasReachedMax,
        status: ListStatus.success,
        matches: [...currentMatchesState.matches, ...data],
      );

      final updatedList = [
        for (var item in state.matchesState)
          if (item.type == event.filter.type) updatedMatchesState else item,
      ];

      emit(state.copyWith(
        matchesState: updatedList,
        lastUpdate: DateTime.now().millisecondsSinceEpoch,
      ));

    } catch (e) {
      debugPrint(e.toString());
      // Create a new failure state
      final failedMatchesState = currentMatchesState.copyWith(
        status: ListStatus.failure,
      );

      // Create a new list with the failed state
      final updatedList = [
        for (var item in state.matchesState)
          if (item.type == event.filter.type) failedMatchesState else item,
      ];

      emit(state.copyWith(
        matchesState: updatedList,
        lastUpdate: DateTime.now().millisecondsSinceEpoch,
      ));
      
      rethrow;
    }
  }

  // Future _fetchMatches(FetchMatchesType event, Emitter<MatchesState> emit) async {
  //   final int index = state.matchesState.indexWhere((e) => e.type == event.filter.type);
  //   final currentMatchesState = state.matchesState[index];

  //   try {
  //     if (currentMatchesState.hasReachesMax) return;

  //     final data = await _matchRepository.getMatchWithGame(event.filter);

  //     final updatedMatchesState = LoadedMatches(
  //       type: currentMatchesState.type,
  //       hasReachesMax: data.isEmpty || data.length < 10,
  //       status: ListStatus.success,
  //       matches: [...currentMatchesState.matches, ...data],
  //     );

  //     final updatedList = [
  //       for (var item in state.matchesState)
  //         if (item.type == event.filter.type) updatedMatchesState else item,
  //     ];

  //     emit(state.copyWith(
  //       matchesState: updatedList,
  //       lastUpdate: DateTime.now().millisecondsSinceEpoch,
  //     ));

  //   } catch (e) {
  //     // Create a new failure state
  //     final failedMatchesState = currentMatchesState.copyWith(
  //       status: ListStatus.failure,
  //     );

  //     // Create a new list with the failed state
  //     final updatedList = [
  //       for (var item in state.matchesState)
  //         if (item.type == event.filter.type) failedMatchesState else item,
  //     ];

  //     emit(state.copyWith(
  //       matchesState: updatedList,
  //       lastUpdate: DateTime.now().millisecondsSinceEpoch,
  //     ));
      
  //     rethrow;
  //   }
  // }
}
