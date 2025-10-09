import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' show droppable;
import 'package:equatable/equatable.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/database/users/user.services.dart';
import 'package:madnolia/models/chat/chat_message_model.dart';
import 'package:madnolia/models/chat/user_messages.body.dart';
import 'package:madnolia/services/messages_service.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../enums/list_status.enum.dart' show ListStatus;

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


        final messages = await MessagesService().getUserChatMessages(
          event.messagesBody.user,
          state.userMessages.isNotEmpty ? state.userMessages.last.id : null
        );

        if(messages.isEmpty){
          return emit(state.copyWith(hasReachedMax: true));
        }

        emit(
          state.copyWith(
            status: ListStatus.success,
            userMessages: [...state.userMessages, ...messages]
          )
        );
      } catch (e) {
        emit(state.copyWith(status: ListStatus.failure));
      }
  }

  Future _onFetchGroupMessages(
    GroupMessageFetched event,
    Emitter<MessageState> emit) async {
      if (state.hasReachedMax) return;

      try {

        String? cursor;

        if(state.groupMessages.isNotEmpty){
          cursor = state.groupMessages.last.id;
        }

        final List<ChatMessage> messages = await MessagesService().getMatchMessages(event.roomId, cursor);

        if(messages.isEmpty){
          return emit(state.copyWith(hasReachedMax: true));
        }
        
        List<String> users = [];
        List<UserData> chatUsers = [];
        chatUsers.addAll(state.users);

        users = messages.map((e) => e.creator).toList();

        users = users.toSet().toList();

        final userDbServices = UserDbServices();

        for (var id in users) {        
          final newChatUser = await userDbServices.getUserById(id);
          if(!chatUsers.contains(newChatUser)) chatUsers.add(newChatUser);
        }

        emit(
          state.copyWith(
            status: ListStatus.success,
            groupMessages: [...state.groupMessages, ...messages],
            users: chatUsers
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

    List<UserData> chatUsers = [];
    chatUsers.addAll(state.users);

    final userDbServices = UserDbServices();


    final userDb = await userDbServices.getUserById(event.message.creator);
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
