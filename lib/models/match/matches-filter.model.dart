// To parse this JSON data, do
//
//     final matchesFilter = matchesFilterFromJson(jsonString);

class MatchesFilter {
  final MatchesFilterType type;
  final SortType sort;
  final int skip;
  final int? platform;

  MatchesFilter({
    required this.type,
    required this.sort,
    required this.skip,
    this.platform,
  });

  // Enhanced serialization for enums
  Map<String, dynamic> toJson() => {
    "type": type.name, // Convert enum to string
    "sort": sort.name, // Convert enum to string
    "skip": skip,
    "platform": platform,
  };

  // For WorkManager data passing
  Map<String, dynamic> toWorkData() => {
    'type': type.index, // Store enum index
    'sort': sort.index,
    'skip': skip,
    'platform': platform,
  };

  factory MatchesFilter.fromWorkData(Map<String, dynamic> data) {
    return MatchesFilter(
      type: MatchesFilterType.values[data['type']],
      sort: SortType.values[data['sort']],
      skip: data['skip'],
      platform: data['platform'],
    );
  }
}

enum MatchesFilterType { all, created, joined }
enum SortType { asc, desc }
