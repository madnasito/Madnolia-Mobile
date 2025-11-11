
import 'package:drift/drift.dart';

class Conversation extends Table {
  TextColumn get id => text()();
  BoolColumn get hasReachedEnd => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
