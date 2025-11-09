// To parse this JSON data, do
//
//     final matchesFilter = matchesFilterFromJson(jsonString);

import 'package:madnolia/enums/sort_type.enum.dart' show SortType;

import '../../enums/platforms_id.enum.dart';

class MatchesFilter {
  final MatchesFilterType type;
  final SortType sort;
  final int skip;
  final int limit;
  final PlatformId? platform;

  MatchesFilter({
    required this.type,
    required this.sort,
    required this.skip,
    this.limit = 10,
    this.platform,
  });

  // Enhanced serialization for enums
  Map<String, dynamic> toJson() => {
    "type": type.name, // Convert enum to string
    "sort": sort.name, // Convert enum to string
    "skip": skip,
    "limit": limit,
    "platform": platform?.id,
  };

  factory MatchesFilter.fromWorkData(Map<String, dynamic> data) {
    return MatchesFilter(
      type: MatchesFilterType.values[data['type']],
      sort: SortType.values[data['sort']],
      skip: data['skip'],
      limit: data['limit'],
      platform: data['platform'].map((x) => PlatformId.values.firstWhere((e) => e.id == x)),
    );
  }
}

enum MatchesFilterType { all, created, joined }
