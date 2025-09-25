import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:madnolia/enums/platforms_id.enum.dart';

class PlatformListConverter extends TypeConverter<List<PlatformId>, String> {
  const PlatformListConverter();

  @override
  List<PlatformId> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];
    return List<PlatformId>.from(jsonDecode(fromDb));
  }

  @override
  String toSql(List<PlatformId> value) {
    return jsonEncode(value);
  }
}