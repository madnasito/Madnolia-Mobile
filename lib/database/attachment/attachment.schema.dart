import 'package:drift/drift.dart';
import 'package:madnolia/enums/attachment_type.dart';

import '../chat_messages/chat_message.schema.dart';

class Attachment extends Table {
  TextColumn get id => text()();
  TextColumn get message => text().references(ChatMessage, #id)();
  TextColumn get thumb => text().nullable()();
  TextColumn get file => text()();
  IntColumn get type => intEnum<AttachmentType>()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}