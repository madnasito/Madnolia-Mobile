import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:madnolia/database/chat_messages/chat_message_repository.dart';
import 'package:madnolia/database/repository_manager.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';
import 'package:madnolia/enums/bloc_status.enum.dart' show BlocStatus;
import 'package:madnolia/models/chat/user_chat.dart';
import 'package:stream_transform/stream_transform.dart';

part 'chats_event.dart';
part 'chats_state.dart';

const chatsThrottleDuration = Duration(milliseconds: 100);
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  final ChatMessageRepository _chatMessageRepository =
      RepositoryManager().chatMessage;

  ChatsBloc() : super(ChatsInitial()) {
    on<UserChatsFetched>(
      _onFetchUserChats,
      transformer: throttleDroppable(chatsThrottleDuration),
    );
    on<WatchUserChats>(_watchUserChats);
    on<RestoreUserChats>(_restoreState);
    // on<UpdateRecipientStatus>(_updateListStatus);
  }

  Future<void> _watchUserChats(
    WatchUserChats event,
    Emitter<ChatsState> emit,
  ) async {
    try {
      debugPrint('Watch user chats bloc');
      await emit.forEach(
        _chatMessageRepository.watchUserChats(),
        onData: (chats) {
          final unreadCount = chats.fold<int>(0, (previousValue, chat) {
            final isNotMyMessage = chat.message.creator == chat.user.id;
            final isUnread =
                chat.message.status == ChatMessageStatus.sent ||
                chat.message.status == ChatMessageStatus.delivered;
            return previousValue + (isNotMyMessage && isUnread ? 1 : 0);
          });
          return state.copyWith(usersChats: chats, unreadCount: unreadCount);
        },
        onError: (error, stackTrace) {
          debugPrint(error.toString());
          debugPrint(stackTrace.toString());
          return state.copyWith(status: BlocStatus.failure);
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future _onFetchUserChats(
    UserChatsFetched event,
    Emitter<ChatsState> emit,
  ) async {
    if (state.hasReachedMax) return;

    try {
      final int skip = state.usersChats.length;

      final isReload = state.status == BlocStatus.initial || event.reload;

      final chats = await _chatMessageRepository.getUsersChats(
        skip: skip,
        reload: isReload,
      );

      if (chats.length < 30) {
        emit(state.copyWith(hasReachedMax: true));
      }

      emit(
        state.copyWith(
          status: BlocStatus.success,
          // usersChats: [...state.usersChats, ...chats]
          unreadCount: chats.fold<int>(0, (previousValue, chat) {
            final isNotMyMessage = chat.message.creator == chat.user.id;
            final isUnread =
                chat.message.status == ChatMessageStatus.sent ||
                chat.message.status == ChatMessageStatus.delivered;
            return previousValue + (isNotMyMessage && isUnread ? 1 : 0);
          }),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: BlocStatus.failure));
    }
  }

  void _restoreState(RestoreUserChats event, Emitter<ChatsState> emit) {
    emit(
      state.copyWith(
        status: BlocStatus.initial,
        hasReachedMax: false,
        usersChats: [],
      ),
    );
  }
}
