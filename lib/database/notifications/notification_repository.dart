import 'package:drift/drift.dart';
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

  Future<List<NotificationData>> getUserNotifications({String? cursorId, bool? reload}) async {
    try {
      if(reload == true) await updateData(cursorId);

      if(cursorId == null) {
        // Getting latest notifications
        List<NotificationData> notificationsData = await (database.select(database.notification)
          ..orderBy([
              (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
              (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)
            ])
          ..limit(20)
        )
        .get();

        return notificationsData;
      }

      // When a cursorId is provided we should return notifications that come after
      // the cursor in the same ordering (date desc, id desc). To do that we first
      // fetch the cursor notification to obtain its date, then query for rows
      // with (date < cursorDate) OR (date == cursorDate AND id < cursorId)
      // which represents items after the cursor when ordering desc by date then id.
      final cursorNotification = await (database.select(database.notification)
        ..where((t) => t.id.equals(cursorId)))
      .getSingleOrNull();

      if (cursorNotification == null) {
        // If the cursor id doesn't exist in local DB, return empty list.
        return <NotificationData>[];
      }

      final DateTime cursorDate = cursorNotification.date;

      List<NotificationData> notificationsData = await (database.select(database.notification)
        ..where((t) =>
          // Use bitwise operators to combine boolean expressions (drift overloads
          // & and | for Expression<bool>), avoiding the instance .and/.or methods.
          t.date.isSmallerThanValue(cursorDate) | (t.date.equals(cursorDate) & t.id.isSmallerThanValue(cursorId))
        )
        ..orderBy([
          (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)
        ])
        ..limit(20)
      )
      .get();

      if(notificationsData.length < 20) {
        await updateData(cursorId);

        notificationsData = await (database.select(database.notification)
          ..where((t) =>
            // Use bitwise operators to combine boolean expressions (drift overloads
            // & and | for Expression<bool>), avoiding the instance .and/.or methods.
            t.date.isSmallerThanValue(cursorDate) | (t.date.equals(cursorDate) & t.id.isSmallerThanValue(cursorId))
          )
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
            (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)
          ])
          ..limit(20)
        )
        .get();
      }

      return notificationsData;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> updateData(String? cursorId) async {
    try {
      List<NotificationModel> apiNotifications = await _notificationsService.getUserNotifications(cursor: cursorId);

      List<NotificationCompanion> notificationsCompanion = apiNotifications.map((n) => n.toCompanion()).toList();

      return await insertOrUpdateMany(notificationsCompanion);

    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> insertOrUpdateMany(List <NotificationCompanion> notifications) async {
    try {

      final notificationsWithSenders = notifications.where((n) => n.sender.value != null).toList();

      List<String> senders = notificationsWithSenders.map((n) => n.sender.value!).toList();

      // Verifyng all senders
      await _userRepository.getUsersByIds(senders);
      return await database.batch((batch) {
        batch.insertAllOnConflictUpdate(database.notification, notifications);
      });
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
  
  Future<int> deleteNotification({required String id }) async {
    try {
      return (database.delete(
        database.notification
      )..where((t) => t.id.equals(id)))
      .go();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }


  Future<int> deleteNotifications() async {
    try {
      return (database.delete(database.notification)).go();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
  Stream<List<NotificationData>> watchAllNotifications() {
    try {
      return database.select(database.notification)
      .watch();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}