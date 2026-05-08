enum ChatMessageEvents {
  initChat('chat:init_chat'),
  message('chat:message'),
  newMessage('chat:new_message'),
  sendedMessage('chat:sended_message'),
  updateRecipientStatus('chat:update_recipient_status'),
  messageRecipientUpdate('chat:message_recipient_update'),
  disconnectChat('chat:disconnect_chat'),
  joinRoom('chat:join_room'),
  leaveRoom('chat:leave_room');

  final String event;
  const ChatMessageEvents(this.event);
}
