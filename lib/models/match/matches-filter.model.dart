// To parse this JSON data, do
//
//     final matchesFilter = matchesFilterFromJson(jsonString);

import 'package:madnolia/enums/match-status.enum.dart';
import 'package:madnolia/enums/sort_type.enum.dart' show SortType;

import '../../enums/platforms_id.enum.dart';

class MatchesFilter {
  final MatchesFilterType type;
  final SortType sort;
  final int limit;
  final MatchesSortBy sortBy;
  final String? cursor;
  final PlatformId? platform;
  final List<MatchStatus>? status;

  MatchesFilter({
    required this.type,
    required this.sort,
    this.cursor,
    this.limit = 10,
    this.sortBy = MatchesSortBy.date,
    this.platform,
    this.status
  });

  // Enhanced serialization for enums
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {
      "type": type.name,
      "sort": sort.name,
      "limit": limit,
      "sortBy": sortBy.name,
    };

    if (cursor != null) {
      json["cursor"] = cursor;
    }
    if (platform != null) {
      json["platform"] = platform?.id;
    }
    if (status != null) {
      json["status"] = status?.map((e) => e.name).toList();
    }

    return json;
  }

  factory MatchesFilter.fromWorkData(Map<String, dynamic> data) {
    return MatchesFilter(
      type: MatchesFilterType.values.byName(data['type']),
      sort: SortType.values.byName(data['sort']),
      cursor: data['cursor'],
      limit: data['limit'],
      sortBy: MatchesSortBy.values.byName(data['sortBy']),
      platform: data['platform'] != null ? PlatformId.values.firstWhere((e) => e.id == data['platform']) : null,
      status: data['status'] != null ? (data['status'] as List).map((e) => MatchStatus.values.byName(e)).toList() : null,
    );
  }
}

enum MatchesFilterType { all, created, joined }

enum MatchesSortBy { date, createdAt }
