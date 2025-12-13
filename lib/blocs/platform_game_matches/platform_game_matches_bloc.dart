import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:madnolia/enums/platforms_id.enum.dart';
import 'package:madnolia/models/match/minimal_match_model.dart';
import 'package:madnolia/services/match_service.dart';

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
        gameMatches: []
      )
    );
  }

  Future<void> _loadPlatformGameMatches(LoadPlatformGameMatches event, Emitter<PlatformGameMatchesState> emit) async {
    try {
      final List info = await _matchService.getMatchesByPlatformAndGame(platform:  event.platformId,game:  event.gameId, skip: state.gameMatches.length);

      final List<MinimalMatch> matches = info.map((e) => MinimalMatch.fromJson(e)).toList();

      emit(
        state.copyWith(
          gameMatches: matches
        )
      );
      
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  } 
}
