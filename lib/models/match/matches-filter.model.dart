// To parse this JSON data, do
//
//     final matchesFilter = matchesFilterFromJson(jsonString);

import 'dart:convert';

MatchesFilter matchesFilterFromJson(String str) => MatchesFilter.fromJson(json.decode(str));

String matchesFilterToJson(MatchesFilter data) => json.encode(data.toJson());

class MatchesFilter {
    MatchesFilterType type;
    String sort;
    int skip;
    int? platform;

    MatchesFilter({
        required this.type,
        required this.sort,
        required this.skip,
        required this.platform,
    });

    factory MatchesFilter.fromJson(Map<String, dynamic> json) => MatchesFilter(
        type: json["type"],
        sort: json["sort"],
        skip: json["skip"],
        platform: json["platform"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "sort": sort,
        "skip": skip,
        "platform": platform,
    };
}

enum MatchesFilterType {
  all,
  created,
  joined
}
