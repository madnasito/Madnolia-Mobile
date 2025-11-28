import 'dart:convert';

import 'package:drift/drift.dart';

class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.isEmpty || fromDb == '[]') return [];
    
    try {
      final parsed = json.decode(fromDb) as List;
      return parsed.map((e) {
        if (e is String) return e;
        return e.toString();
      }).toList();
    } catch (e) {
      print('Error parsing string list: $e');
      return [];
    }
  }

  @override
  String toSql(List<String> value) {
    return jsonEncode(value);
  }
}