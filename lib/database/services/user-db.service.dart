import 'package:flutter/widgets.dart' show debugPrint;
import 'package:madnolia/database/providers/user_db.dart';
import 'package:madnolia/services/user_service.dart' show UserService;


Future<UserDb> getUserDb(String id) async {
  try {
    final now = DateTime.now();
    final existingUser = await UserProvider.getUser(id);
    
    // Return cached user if recent
    if (existingUser != null && now.difference(existingUser.lastUpdated).inHours < 1) {
      return existingUser;
    }
    
    // Fetch fresh data
    final userInfo = await UserService().getUserInfoById(id);
    final userDb = UserDb.fromMap({
      ...userInfo,
      columnLastUpdated: now.millisecondsSinceEpoch,
    });
    
    // Always use update - safer than trying to decide insert/update
    await UserProvider.updateUser(userDb);
    
    return userDb;
  } catch (e) {
    debugPrint('Error in getUserDb: $e');
    rethrow;
  }
}