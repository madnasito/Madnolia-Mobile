import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:madnolia/enums/platforms_id.enum.dart';
import 'package:madnolia/models/match/match_model.dart';
import 'package:madnolia/services/match_service.dart';

import '../../enums/bloc_status.enum.dart';

part 'platform_game_matches_event.dart';
part 'platform_game_matches_state.dart';

class PlatformGameMatchesBloc extends Bloc<PlatformGameMatchesEvent, PlatformGameMatchesState> {
  final MatchService _matchService = MatchService();
  PlatformGameMatchesBloc() : super(PlatformGameMatchesState()) {
    on<LoadPlatformGameMatches>(_loadPlatformGameMatches);
    on<RestorePlatformGameMatches>(_restoreState);
  }

  Future<void> _restoreState(RestorePlatformGameMatches event, emit) async {
    emit(
      state.copyWith(
        gameMatches: [],
        hasReachedMax: false,
        status: BlocStatus.initial
      )
    );
  }

  Future<void> _loadPlatformGameMatches(LoadPlatformGameMatches event, Emitter<PlatformGameMatchesState> emit) async {
    try {

      if (state.hasReachedMax) return;
      
      final List<Match> currentMatches = state.gameMatches;

      final List<Match> apiMatches = await _matchService.getMatchesByPlatformAndGame(platform:  event.platformId,game:  event.gameId, skip: state.gameMatches.length);

      bool hasReachedMax = state.hasReachedMax;

      if (apiMatches.length < 20) {
        hasReachedMax = true;
      }

      emit(
        state.copyWith(
          gameMatches: [...currentMatches, ...apiMatches],
          hasReachedMax: hasReachedMax,
          status: BlocStatus.success
        )
      );
      
    } catch (e) {
      debugPrint(e.toString());
      emit(
        state.copyWith(
          status: BlocStatus.failure
        )
      );
      rethrow;
    }
  } 
}
