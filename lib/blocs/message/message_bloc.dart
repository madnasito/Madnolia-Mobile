import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart' show debugPrint;
import 'package:madnolia/database/database.dart';
import 'package:madnolia/database/repository_manager.dart';
import 'package:madnolia/enums/chat_message_type.enum.dart';
import 'package:madnolia/models/chat/user_messages.body.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../enums/list_status.enum.dart' show ListStatus;
import '../../models/chat/chat_message_with_user.dart';

part 'message_event.dart';
part 'message_state.dart';

const throttleDuration = Duration(milliseconds: 100);
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MessageBloc extends Bloc<MessageEvent, MessageState> {

  final _chatMessageRepository = RepositoryManager().chatMessage;
  final _conversationRepository = RepositoryManager().conversation;

  MessageBloc() : super(MessageInitial()) {
    on<MessageFetched>(
      _onFetchRoomMessages, transformer: throttleDroppable(throttleDuration));

    // on<GroupMessageFetched>(
    //   _onFetchGroupMessages, transformer: throttleDroppable(throttleDuration));
    
    // on<AddIndividualMessage>(_addIndividualMessage);
    // on<AddRoomMessage>(_addRoomMessage);

    on<UpdateUnreadUserChatCount>(_updateUnreadUserChatsCount);

    on<WatchRoomMessages>(_watchRoomMessages, transformer: restartable());

    on<RestoreState>(_restoreState);
  }


  Future<void> _watchRoomMessages(
    WatchRoomMessages event,
    Emitter<MessageState> emit) async {

      try {
        debugPrint('Watch room bloc');
        await emit.forEach(
          _chatMessageRepository.watchMessagesInRoom(
            conversationId: event.roomId),
            onData: (messages) => state.copyWith(roomMessages: messages),
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

  Future<void> _onFetchRoomMessages(
    MessageFetched event,
    Emitter<MessageState> emit) async {
      debugPrint('Has reached max: ${state.hasReachedMax}');
      if (state.hasReachedMax) return;

      try {

        String? cursor;

        if(state.roomMessages.isNotEmpty){
          cursor = state.roomMessages.last.chatMessage.id;
        }

        final List<ChatMessageData> messages = await _chatMessageRepository.getMessagesInRoom(
          conversationId: event.roomId,
          type: event.type,
          cursorId: cursor
        );

        final conversation = await _conversationRepository.get(event.roomId);
        final bool conversationHasReachedEnd = conversation?.hasReachedEnd ?? false;

        if(messages.isEmpty && conversationHasReachedEnd){
          return emit(state.copyWith(hasReachedMax: true));
        }

        emit(
          state.copyWith(
            status: ListStatus.success,
            hasReachedMax: messages.isEmpty && conversationHasReachedEnd, // Update hasReachedMax here
          )
        );

      } catch (e) {
        emit(state.copyWith(status: ListStatus.failure));
      }
    }

  void _restoreState(RestoreState event, Emitter<MessageState> emit){
    emit(
      state.copyWith(
      status: ListStatus.initial,
      unreadUserChats: 0,
      roomMessages: [],
      hasReachedMax: false
    ));
  }

  void _updateUnreadUserChatsCount(UpdateUnreadUserChatCount event, Emitter<MessageState> emit) =>
  emit(
    state.copyWith(
      unreadUserChats: state.unreadUserChats + event.value
    )
  );
}
