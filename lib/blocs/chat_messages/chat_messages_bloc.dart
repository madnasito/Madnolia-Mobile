import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/organism/chat_message_organism.dart';

part 'chat_messages_event.dart';
part 'chat_messages_state.dart';

class ChatMessagesBloc extends Bloc<ChatMessagesEvent, ChatMessagesState> {
  ChatMessagesBloc() : super(const ChatMessagesState()) {
    on<ChatMessagesEvent>((event, emit) {
      if( event is RestoreMessages){
        emit(state.copyWith(
          chatMessages: []
        ));
      }

      if(event is PushNewMessages){

        List<GroupChatMessageOrganism> newMessages = state.chatMessages.toList();



        newMessages.addAll(event.newMessages);
        // state.chatMessages.addAll(event.newMessages);
        emit(state.copyWith(
          chatMessages: newMessages
        ));

      }

      if( event is IsLoading ){
        emit(state.copyWith(isLoadingMessages: event.loading));
      }
    });
  }

  void restoreMessages(){
    add(RestoreMessages());
  }

  void pushMessages(List<GroupChatMessageOrganism> messages) {
    add(PushNewMessages(newMessages: messages));
  }

  void isLoading(bool loading) {
    add(IsLoading(loading: loading));
  }
}
