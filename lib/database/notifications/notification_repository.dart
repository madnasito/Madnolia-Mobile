import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:madnolia/database/database.dart';
import 'package:madnolia/models/notification/notification_model.dart';

import '../../enums/notification_type.enum.dart';
import '../../models/notification/notification_details.dart';
import '../../services/notifications_service.dart';
import '../users/user_repository.dart';
class NotificationRepository {

  final AppDatabase database;
  
  final NotificationsService _notificationsService = NotificationsService();
  late final UserRepository _userRepository;

  NotificationRepository(this.database) {
    _userRepository = UserRepository(database);
  }

  Future<List<NotificationDetails>> getUserNotifications({String? cursorId, bool? reload}) async {
    try {
      if(reload == true) await updateData(cursorId);

      final query = database.select(database.notification).join([
        leftOuterJoin(database.user, database.user.id.equalsExp(database.notification.sender)),
      ]);

      if (cursorId != null) {
        final cursorNotification = await (database.select(database.notification)
          ..where((t) => t.id.equals(cursorId)))
        .getSingleOrNull();

        if (cursorNotification != null) {
          final cursorDate = cursorNotification.date;
          query.where(
            database.notification.date.isSmallerThanValue(cursorDate) |
            (database.notification.date.equals(cursorDate) & database.notification.id.isSmallerThanValue(cursorId))
          );
        }
      }

      query
        ..orderBy([
            OrderingTerm(expression: database.notification.date, mode: OrderingMode.desc),
            OrderingTerm(expression: database.notification.id, mode: OrderingMode.desc)
          ])
        ..limit(20);

      final results = await query.get();

      if (results.length < 20 && cursorId != null) {
        await updateData(cursorId);
        final newResults = await query.get();
        return newResults.map((row) {
          return NotificationDetails(
            notification: row.readTable(database.notification),
            user: row.readTableOrNull(database.user),
          );
        }).toList();
      }

      return results.map((row) {
        return NotificationDetails(
          notification: row.readTable(database.notification),
          user: row.readTableOrNull(database.user),
        );
      }).toList();
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

  Future<int> deleteRequestNotification({required String senderId }) async {
    try {
      return (database.delete(
        database.notification
      )..where((t) => t.sender.equals(senderId) & t.type.equals(NotificationType.request.index)))
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

  Future<int> deleteOldInvitationNotifications() async {
    try {
      final eightMonthsAgo = DateTime.now().subtract(const Duration(days: 8 * 30)); // Approximate 8 months
      return (database.delete(database.notification)..where((t) => t.type.equals(NotificationType.matchInvitation.index) & t.date.isSmallerThanValue(eightMonthsAgo))).go();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<int> deleteOldNotifications() async {
    try {
      final eightMonthsAgo = DateTime.now().subtract(const Duration(days: 8 * 30)); // Approximate 8 months
      return (database.delete(database.notification)..where((t) => t.date.isSmallerThanValue(eightMonthsAgo))).go();
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
  Stream<List<NotificationDetails>> watchAllNotifications() {
    try {
      debugPrint('Starting to watch notifications from database');
      
      // Build joined query first, then apply ordering via cascade
      final query = database.select(database.notification).join([
        leftOuterJoin(database.user, database.user.id.equalsExp(database.notification.sender)),
      ]);

      query
        .orderBy([
            OrderingTerm(expression: database.notification.date, mode: OrderingMode.desc),
            OrderingTerm(expression: database.notification.id, mode: OrderingMode.desc)
          ]);

      return query.watch().map((rows) {
        final notifications = rows.map((row) {
          return NotificationDetails(
            notification: row.readTable(database.notification),
            user: row.readTableOrNull(database.user),
          );
        }).toList();
        
        debugPrint('Database stream emitted ${notifications.length} notifications');
        return notifications;
      });
    } catch (e) {
      debugPrint('Error in watchAllNotifications: $e');
      rethrow;
    }
  }
}