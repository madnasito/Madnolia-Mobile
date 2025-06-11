import 'package:flutter/widgets.dart' show debugPrint;
import 'package:madnolia/database/providers/user_db.dart';
import 'package:madnolia/services/user_service.dart' show UserService;


Future<UserDb> getUserDb(String id) async {
  try {
    // Obtener usuario de la base de datos local
    // await UserProvider.clearTable();
    final existingUser  = await UserProvider.getUser(id);
    final now = DateTime.now();
    
    // Si el usuario existe y fue actualizado hace menos de una hora, devolverlo
    if (existingUser != null && 
        now.difference(existingUser.lastUpdated).inHours < 1) {
      return existingUser;
    }
    
    // Si no existe o necesita actualización, obtener del servicio
    final userInfo = await UserService().getUserInfoById(id);
    final userDb = UserDb.fromMap({
      ...userInfo,
      columnLastUpdated: now.millisecondsSinceEpoch, // Actualizar timestamp
    });
    
    // Insertar o actualizar en la base de datos
    if (existingUser == null) {
      await UserProvider.insertUser(userDb);
    } else {
      await UserProvider.updateUser(userDb);
    }
    
    return userDb;
  } catch (e) {
    debugPrint('Error in getUserDb: $e');
    rethrow;
  }
}