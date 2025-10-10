
import 'package:drift/drift.dart';

class Conversation extends Table {
  TextColumn get conversationId => text()();
  BoolColumn get hasReachedEnd => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {conversationId};
}
