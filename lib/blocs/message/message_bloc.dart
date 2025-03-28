import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' show droppable;
import 'package:equatable/equatable.dart';
import 'package:madnolia/models/chat/individual_message_model.dart';
// import 'package:madnolia/models/chat/message_model.dart';
import 'package:madnolia/models/chat/user_messages.body.dart';
import 'package:madnolia/services/messages_service.dart';
import 'package:stream_transform/stream_transform.dart';

part 'message_event.dart';
part 'message_state.dart';

const throttleDuration = Duration(milliseconds: 100);
int skip = 0;


EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageInitial()) {
    on<UserMessageFetched>(
      _onFetchUserMessages, transformer: throttleDroppable(throttleDuration));
  }

  Future _onFetchUserMessages(
    UserMessageFetched event,
    Emitter<MessageState> emit) async {
      if(state.hasReachedMax) return ;

      try {
        event.messagesBody.skip = skip;
        final messages = await MessagesService().getUserChatMessages(event.messagesBody);
        skip++;

        if(messages.isEmpty){
          return emit(state.copyWith(hasReachedMax: true));
        }

        emit(
          state.copyWith(
            status: MessageStatus.success,
            messages: [...state.messages, ...messages]
          )
        );
      } catch (e) {
        emit(state.copyWith(status: MessageStatus.failure));
      }
  }


}
