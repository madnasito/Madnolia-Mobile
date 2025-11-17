part of 'chats_bloc.dart';

sealed class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

class UserChatsFetched extends ChatsEvent {
  final bool reload;
  const UserChatsFetched({ this.reload = false });
}

class RestoreUserChats extends ChatsEvent {}


class WatchUserChats extends ChatsEvent {}

class UpdateRecipientStatus extends ChatsEvent {
  final String messageId;
  final ChatMessageStatus status;
  const UpdateRecipientStatus({ required this.messageId, required this.status });
}