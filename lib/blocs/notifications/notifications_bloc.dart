import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:madnolia/database/repository_manager.dart';
import 'package:madnolia/enums/list_status.enum.dart';
import 'package:madnolia/models/notification/notification_details.dart';
import 'package:stream_transform/stream_transform.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

const throttleDuration = Duration(milliseconds: 100);
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {

  final _notificationsRepository = RepositoryManager().notification;

  NotificationsBloc() : super(const NotificationsState()) {
    on<LoadNotifications>( _loadNotifications, transformer: throttleDroppable(throttleDuration));
    on<RestoreNotificationsState>(_restore);
    on<WatchNotifications>(_watchNotifications);
  }

  void _restore(
    RestoreNotificationsState event,
    Emitter<NotificationsState> emit
  ){
    emit(
      state.copyWith(
        data: [],
        hasReachedMax: false,
        status: ListStatus.initial
      )
    );
  }

  Future<void> _loadNotifications(LoadNotifications event, Emitter<NotificationsState> emit) async {

    debugPrint('hasReachedMax: ${state.hasReachedMax}, reload: ${event.reload}');

    if (state.hasReachedMax && !event.reload) return;

    // On pull-to-refresh, reset the state completely.
    if (event.reload) {
      emit(const NotificationsState());
    }


    try {
      final cursorId = event.reload ? null : state.data.lastOrNull?.notification.id;

      bool reload = event.reload || state.status == ListStatus.initial;

      debugPrint('Loading notifications with cursorId: $cursorId, reload: $reload');

      final newNotifications = await _notificationsRepository.getUserNotifications(
        reload: reload,
        cursorId: cursorId,
      );

      final hasReachedMax = newNotifications.length < 20;

      emit(
        state.copyWith(
          status: ListStatus.success,
          // Append new notifications to the existing list.
          data: event.reload ? newNotifications : (List.of(state.data)..addAll(newNotifications)),
          hasReachedMax: hasReachedMax,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: ListStatus.failure));
      rethrow;
    }
  }

  Future<void> _watchNotifications(
    WatchNotifications event,
    Emitter<NotificationsState> emit,
  ) async {
    try {
      debugPrint('Watch notifications started');
      await emit.forEach<List<NotificationDetails>>(
        _notificationsRepository.watchAllNotifications(),
        onData: (notifications) {

          return state.copyWith(
            data: notifications,
          );
        },
        onError: (error, stackTrace) {
          debugPrint('Stream error: $error');
          debugPrint(stackTrace.toString());
          return state.copyWith(status: ListStatus.failure);
        },
      );
    } catch (e) {
      debugPrint('Watch notifications error: $e');
      emit(state.copyWith(status: ListStatus.failure));
    }
  }
}
