import 'package:flutter/foundation.dart' show debugPrint;
import 'package:madnolia/database/database.dart';
import 'package:madnolia/models/notification/notification_model.dart';

import '../../services/notifications_service.dart';
import '../users/user_repository.dart';
class NotificationRepository {

  final AppDatabase database;
  
  final NotificationsService _notificationsService = NotificationsService();
  late final UserRepository _userRepository;

  NotificationRepository(this.database) {
    _userRepository = UserRepository(database);
  }

  Future<List<NotificationData>> getUserNotifications({bool? reload}) async {
    try {
      if(reload == true) await updateData();

      List<NotificationData> notificationsData = await database.select(database.notification).get();

      return notificationsData;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> updateData() async {
    try {
      List<NotificationModel> apiNotifications = await _notificationsService.getUserNotifications();

      List<NotificationCompanion> notificationsCompanion = apiNotifications.map((n) => n.toCompanion()).toList();

      return await insertOrUpdateMany(notificationsCompanion);

    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> insertOrUpdateMany (List <NotificationCompanion> notifications) async {
    try {

      final notificationsWithSenders = notifications.where((n) => n.sender.value != null).toList();

      List<String> senders = notificationsWithSenders.map((n) => n.sender.value!).toList();

      // Verifyng all senders
      _userRepository.getUsersByIds(senders);
      return await database.batch((batch) {
        batch.insertAllOnConflictUpdate(database.notification, notifications);
      });
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}