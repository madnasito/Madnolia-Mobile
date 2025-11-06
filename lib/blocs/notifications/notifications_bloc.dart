import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:madnolia/database/database.dart';
import 'package:madnolia/database/repository_manager.dart';
import 'package:madnolia/enums/list_status.enum.dart';
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

  NotificationsBloc() : super(NotificationsState()) {
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

  Future _loadNotifications(LoadNotifications event,Emitter<NotificationsState> emit) async {
    try {

      if (state.hasReachedMax) return;

      String? cursorId;

      if(event.reload == false && state.data.isNotEmpty && state.status != ListStatus.initial) {
        cursorId = state.data.last.id;
      }

      final isReload = state.status == ListStatus.initial || event.reload;

      final notifications = await _notificationsRepository.getUserNotifications(
        reload: isReload,
        cursorId: cursorId
      );

      bool hasReachedMax = false;

      if(notifications.length < 20) hasReachedMax = true;

      List<NotificationData> stateNotifications = [];

      stateNotifications.addAll(state.data);

      stateNotifications.addAll(notifications);
      
      emit(
        state.copyWith(
          data: stateNotifications,
          hasReachedMax: hasReachedMax,
          status: ListStatus.success
        )
      );
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

  void _watchNotifications(
    WatchNotifications event,
    Emitter<NotificationsState> emit
  ) async {
    try {
      debugPrint('Watch notifications');
      await emit.forEach(
        _notificationsRepository.watchAllNotifications(),
        onData: (notifications) => state.copyWith(data: notifications),
        onError: (error, stackTrace) {
          debugPrint(error.toString());
          debugPrint(stackTrace.toString());
          return state.copyWith(status: ListStatus.failure);
        }
      );
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

}
