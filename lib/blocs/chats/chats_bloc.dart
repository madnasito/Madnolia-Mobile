import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';
import 'package:madnolia/enums/message_status.enum.dart' show MessageStatus;
import 'package:madnolia/models/chat/message_model.dart';
import 'package:madnolia/models/chat/user_chat_model.dart';
import 'package:madnolia/services/messages_service.dart';
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
  ChatsBloc() : super(ChatsInitial()) {

    on<UserChatsFetched>(_onFetchUserChats, transformer: throttleDroppable(chatsThrottleDuration));
    on<AddIndividualMessage>(_addIndividualMessage);
    on<RestoreUserChats>(_restoreState);
    on<UpdateRecipientStatus>(_updateMessageStatus);
    
  }

  Future _onFetchUserChats(UserChatsFetched event, Emitter<ChatsState> emit) async {
    if(state.hasReachedMax) return;

    try {
      // final int skip = state.usersChats.length % 30 == 0 ? state.usersChats.length / 30 : 0;

      final chats = await MessagesService().getChats(0);

      if(chats.length < 30){
        emit(state.copyWith(hasReachedMax: true));
      }
      
      emit(
        state.copyWith(
          status: MessageStatus.success,
          usersChats: [...state.usersChats, ...chats]
        )
      );
    } catch (e) {
      emit(state.copyWith(status: MessageStatus.failure));
    }
  }

  void _updateMessageStatus(UpdateRecipientStatus event, Emitter<ChatsState> emit) {

    final existsMessage = state.usersChats.indexWhere((e) => e.message.id == event.messageId);

    if(existsMessage == -1) return;

    // Create a new list to ensure immutability
    final List<UserChat> chats = List.from(state.usersChats);

    chats[existsMessage].message.status = event.status;

    emit(
      state.copyWith(
        usersChats: chats
      )
    );
  }

  void _restoreState(RestoreUserChats event, Emitter<ChatsState> emit) {
    emit(
      state.copyWith(
        status: MessageStatus.initial,
        hasReachedMax: false,
        usersChats: []
      )
    );
  }

  void _addIndividualMessage( AddIndividualMessage event, Emitter<ChatsState> emit) {
    

    // Create a new list to ensure immutability
    final List<UserChat> updatedChats = List.from(state.usersChats);
    
    // Find index of existing chat if it exists
    final existingChatIndex = updatedChats.indexWhere(
      (chat) => chat.message.conversation == event.message.conversation
    );

    UserChat chatState;

    if(existingChatIndex != -1) {
      chatState = state.usersChats.firstWhere((e) => e.message.conversation == event.message.conversation);
      chatState.message = event.message;
      updatedChats.removeWhere((e) => e.message.conversation == event.message.conversation);
    } else {
      chatState = UserChat(id: event.message.id, unreadCount: 1, message: event.message);
    }

    updatedChats.insert(0, chatState);

    emit(
      state.copyWith(
        usersChats: updatedChats
      )
    );
  }
}
