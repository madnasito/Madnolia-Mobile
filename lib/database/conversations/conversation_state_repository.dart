
import 'package:flutter/widgets.dart' show debugPrint;
import 'package:madnolia/database/database.dart';

class ConversationRepository {

  final AppDatabase database;

  ConversationRepository(this.database);

  Future<void> createOrUpdate(ConversationCompanion conversationState) async {
    try {
      await database.into(database.conversation).insertOnConflictUpdate(conversationState);
    } catch (e) {
      debugPrint('Error in create or update conversation state: $e');
      rethrow;
    }
  }

  Future<ConversationData?> get(String conversationId) async {
    try {
      return await (database.select(database.conversation)..where((tbl) => tbl.conversationId.equals(conversationId))).getSingleOrNull();
    } catch (e) {
      debugPrint('Error in get conversation state: $e');
      rethrow;
    }
  }
}
