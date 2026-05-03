enum NotificationEvents {
  standardNotification('notification:standard_notification'),
  notificationDeleted('notification:deleted'),
  delete('notification:delete'),
  deleteChatNotifications('notification:delete_chat_notifications'),
  deleteAllNotifications('notification:delete_all_notifications');

  final String event;
  const NotificationEvents(this.event);
}
