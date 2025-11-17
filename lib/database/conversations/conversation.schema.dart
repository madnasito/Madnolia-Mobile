
import 'package:drift/drift.dart';

class Conversation extends Table {
  TextColumn get id => text()();
  IntColumn get unreadCount => integer().withDefault(const Constant(0))();
  BoolColumn get hasReachedEnd => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
