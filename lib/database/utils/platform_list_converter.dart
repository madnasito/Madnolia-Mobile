import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:madnolia/enums/platforms_id.enum.dart';

class PlatformListConverter extends TypeConverter<List<PlatformId>, String> {
  const PlatformListConverter();

  @override
  List<PlatformId> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];
    final List<dynamic> list = jsonDecode(fromDb);
    return list
        .map((e) => PlatformId.values.firstWhere((p) => p.id == e))
        .toList();
  }

  @override
  String toSql(List<PlatformId> value) {
    return jsonEncode(value.map((e) => e.id).toList());
  }
}