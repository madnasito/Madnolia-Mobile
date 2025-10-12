import 'package:drift/drift.dart';
import 'package:madnolia/enums/chat_message_status.enum.dart';
import 'package:madnolia/enums/chat_message_type.enum.dart';
import '../users/user.schema.dart';

class ChatMessage extends Table {
  TextColumn get id => text()();
  IntColumn get status => intEnum<ChatMessageStatus>()();
  TextColumn get content => text()();
  TextColumn get conversation => text()();
  TextColumn get creator => text().references(User, #id)();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  TextColumn get parentMessage => text().nullable().references(ChatMessage, #id)();
  IntColumn get type => intEnum<ChatMessageType>()();

  @override
  Set<Column> get primaryKey => {id};
}