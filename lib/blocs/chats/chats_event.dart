part of 'chats_bloc.dart';

sealed class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class UserChatsFetched extends ChatsEvent {

}

class RestoreUserChats extends ChatsEvent {}

class AddIndividualMessage extends ChatsEvent {
  final ChatMessage message;

  const AddIndividualMessage({ required this.message});
}

class ReadChat extends ChatsEvent {
  final String conversation;
  const ReadChat({ required this.conversation });
}

class UpdateRecipientStatus extends ChatsEvent {
  final String messageId;
  final ChatMessageStatus status;
  const UpdateRecipientStatus({ required this.messageId, required this.status });
}