import 'package:drift/drift.dart';
import 'package:madnolia/enums/notification_configuration_status.dart';

import '../../enums/notification_configuration_type.enum.dart';

class NotificationsConfig extends Table {
  TextColumn get origin => text()();
  IntColumn get type => intEnum<NotificationConfigurationType>()();
  IntColumn get status => intEnum<NotificationConfigurationStatus>()();
  DateTimeColumn get changeAt => dateTime().nullable()();
}