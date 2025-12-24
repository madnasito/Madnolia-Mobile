import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:madnolia/database/database.dart';

import '../../database/repository_manager.dart';
import '../../enums/list_status.enum.dart';
part 'friendships_event.dart';
part 'friendships_state.dart';

class FriendshipsBloc extends Bloc<FriendshipsEvent, FriendshipsState> {

  final _friendshipRepository = RepositoryManager().friendship;
  final _userRepository = RepositoryManager().user;

  FriendshipsBloc() : super(FriendshipsState()) {
    on<LoadFriendships>(_loadFriendships);
    on<RestoreFriendshipsState>(_restoreState);
  }

  Future<void> _loadFriendships(LoadFriendships event, Emitter<FriendshipsState> emit) async {

    try {
      debugPrint('Loading friendships...');
      if(state.hasReachedMax) return;

      final List<UserData> currentData = state.friendshipsUsers;

      debugPrint(currentData.toString());

      final List<FriendshipData> apiData = await _friendshipRepository.getAllFriendships(reload: event.reload, page: state.page);

      debugPrint('Api data ${currentData.toString()}');

      final usersData = await _userRepository.getUsersByIds(apiData.map((f) => f.user).toList());

      debugPrint('User data ${usersData.toString()}');

      bool hasReachedMax = state.hasReachedMax;

      if (apiData.length < 20) {
        hasReachedMax = true;
      }

      emit(
        state.copyWith(
          friendshipsUsers: [...currentData, ...usersData],
          hasReachedMax: hasReachedMax,
          status: ListStatus.success,
          page: state.page + 1
        )
      );

      debugPrint('User data ${state.status.toString()}');
    } catch (e) {
      debugPrint(e.toString());
      emit(
        state.copyWith(
          status: ListStatus.failure
        )
      );
      rethrow;
    }
  }

  void _restoreState(RestoreFriendshipsState event, Emitter<FriendshipsState> emit) {
    emit(
      state.copyWith(
        friendshipsUsers: [],
        hasReachedMax: false,
        status: ListStatus.initial,
        page: 0
      )
    );
  }
}
