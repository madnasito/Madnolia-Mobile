enum UserEvents {
  updateAvailability('user:update_availability'),
  logout('user:logout'),
  requestConnection('user:request_connection'),
  newRequestConnection('user:new_request_connection'),
  acceptRequest('user:accept_request'),
  requestAccepted('user:request_accepted'),
  rejectConnection('user:reject_connection'),
  connectionRejected('user:connection_rejected'),
  cancelConnection('user:cancel_connection'),
  connectionCanceled('user:connection_canceled'),
  removePartner('user:remove_partner'),
  removedPartner('user:removed_partner'),
  logoutDevice('user:logout_device'),
  readAllNotifications('user:read_all_notifications'),
  readNotification('user:read_notification'),
  notificationsRead('user:notifications_read'),
  updateUserName('user:update_username');

  final String event;
  const UserEvents(this.event);
}
