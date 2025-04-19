import 'package:flutter/widgets.dart' show debugPrint;
import 'package:madnolia/services/database/user_db.dart';
import 'package:madnolia/services/user_service.dart' show UserService;

Future<UserDb> getUserDb(String id) async {
  try {
    
    // Ensure database is properly initialized
    
    // Check if user exists

    // await UserProvider._getDatabase()
    final existingUser = await UserProvider.getUser(id);
    if (existingUser != null) {
      return existingUser;
    }
    
    // Fetch from service if not in DB
    final userInfo = await UserService().getUserInfoById(id);
    final userDb = UserDb.fromMap(userInfo);
    
    // Insert and return
    await UserProvider.insertUser(userDb);
    return userDb;
  } catch (e) {
    debugPrint('Error in getUserDb: $e');
    rethrow;
  } finally {
    // Consider whether to close here or manage provider lifecycle differently
  }
}