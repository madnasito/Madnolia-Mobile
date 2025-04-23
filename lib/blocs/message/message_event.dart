part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

final class UserMessageFetched extends MessageEvent {
  final UserMessagesBody messagesBody;

  const UserMessageFetched({ required this.messagesBody});
}

final class GroupMessageFetched extends MessageEvent {
  final String roomId;

  const GroupMessageFetched({ required this.roomId });
}

final class RestoreState extends MessageEvent {}

final class AddIndividualMessage extends MessageEvent {
  final ChatMessage message;

  const AddIndividualMessage({ required this.message});
}

final class AddRoomMessage extends MessageEvent {
  final ChatMessage message;
  const AddRoomMessage({ required this.message });
}

final class AddUser extends MessageEvent {
  final String userId;
  const AddUser( { required this.userId });
}
