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

    on<WatchNotifications>(_watchNotifications);
  }

  Future _loadNotifications(LoadNotifications event,Emitter<NotificationsState> emit) async {
    try {  
      String? cursorId;
      if(event.reload == false && state.data.isNotEmpty) {
        cursorId = state.data.last.id;
      }

      final notifications = await _notificationsRepository.getUserNotifications(
        reload: state.status == ListStatus.initial ? true : event.reload,
        cursorId: cursorId
      );

      bool hasReachedMax = false;

      if(notifications.length < 20) hasReachedMax = true;
      emit(
        state.copyWith(
          data: notifications,
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
