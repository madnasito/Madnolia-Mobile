part of 'chat_messages_bloc.dart';

sealed class ChatMessagesEvent extends Equatable {
  const ChatMessagesEvent();

  @override
  List<Object> get props => [];
}

class PushNewMessages extends ChatMessagesEvent {
  final List<GroupChatMessageOrganism> newMessages;

  const PushNewMessages({required this.newMessages});
}

class RestoreMessages extends ChatMessagesEvent {
  
}

class IsLoading extends ChatMessagesEvent {
  final bool loading;

  const IsLoading({required this.loading});
}
