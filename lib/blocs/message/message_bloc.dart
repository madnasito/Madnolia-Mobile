import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' show droppable;
import 'package:equatable/equatable.dart';
import 'package:madnolia/models/chat/message_model.dart';
import 'package:madnolia/models/chat/user_messages.body.dart';
import 'package:madnolia/database/providers/user_db.dart' show UserDb;
import 'package:madnolia/services/messages_service.dart';
import 'package:madnolia/database/services/user-db.service.dart';
import 'package:stream_transform/stream_transform.dart';

part 'message_event.dart';
part 'message_state.dart';

const throttleDuration = Duration(milliseconds: 100);
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageInitial()) {
    on<UserMessageFetched>(
      _onFetchUserMessages, transformer: throttleDroppable(throttleDuration));

    on<GroupMessageFetched>(
      _onFetchGroupMessages, transformer: throttleDroppable(throttleDuration));
    
    on<AddIndividualMessage>(_addIndividualMessage);
    on<AddRoomMessage>(_addRoomMessage);

    on<UpdateUnreadUserChatCount>(_updateUnreadUserChatsCount);

    on<RestoreState>(_restoreState);
  }

  Future _onFetchUserMessages(
    UserMessageFetched event,
    Emitter<MessageState> emit) async {
      if(state.hasReachedMax) return ;

      try {
        event.messagesBody.skip = state.userMessages.length;
        final messages = await MessagesService().getUserChatMessages(event.messagesBody);

        if(messages.isEmpty){
          return emit(state.copyWith(hasReachedMax: true));
        }

        emit(
          state.copyWith(
            status: MessageStatus.success,
            userMessages: [...state.userMessages, ...messages]
          )
        );
      } catch (e) {
        emit(state.copyWith(status: MessageStatus.failure));
      }
  }

  Future _onFetchGroupMessages(
    GroupMessageFetched event,
    Emitter<MessageState> emit) async {
      if (state.hasReachedMax) return;

      try {
        final List<ChatMessage> messages = await MessagesService().getMatchMessages(event.roomId, state.groupMessages.length);

        if(messages.isEmpty){
          return emit(state.copyWith(hasReachedMax: true));
        }
        
        List<String> users = [];
        List<UserDb> chatUsers = [];
        chatUsers.addAll(state.users);

        users = messages.map((e) => e.creator).toList();

        users = users.toSet().toList();

        for (var id in users) {        
          final newChatUser = await getUserDb(id);
          if(!chatUsers.contains(newChatUser)) chatUsers.add(newChatUser);
        }

        emit(
          state.copyWith(
            status: MessageStatus.success,
            groupMessages: [...state.groupMessages, ...messages],
            users: chatUsers
          )
        );
      } catch (e) {
        emit(state.copyWith(status: MessageStatus.failure));
      }
    }

  void _restoreState(RestoreState event, Emitter<MessageState> emit){
    emit(
      state.copyWith(
      status: MessageStatus.initial,
      unreadUserChats: 0,
      userMessages: [],
      groupMessages: [],
      hasReachedMax: false
    ));
  }

  void _addIndividualMessage( AddIndividualMessage event, Emitter<MessageState> emit) => emit(
    state.copyWith(
      userMessages: [event.message, ...state.userMessages]
    )
  );

  void _addRoomMessage( AddRoomMessage event, Emitter<MessageState> emit ) async {

    List<UserDb> chatUsers = [];
    chatUsers.addAll(state.users);

    final userDb = await getUserDb(event.message.creator);
    if(!chatUsers.contains(userDb)) chatUsers.add(userDb);

    emit(
      state.copyWith(
        groupMessages: [event.message, ...state.groupMessages],
        users: chatUsers
      )
    );
  }

  void _updateUnreadUserChatsCount(UpdateUnreadUserChatCount event, Emitter<MessageState> emit) =>
  emit(
    state.copyWith(
      unreadUserChats: state.unreadUserChats + event.value
    )
  );
}
