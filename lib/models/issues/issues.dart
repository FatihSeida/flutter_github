// To parse this JSON data, do
//
//     final issues = issuesFromMap(jsonString);

import 'dart:convert';

import '/models/models.dart';

part 'issueItem.dart';

class Issues {
  Issues({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  int totalCount;
  bool incompleteResults;
  List<IssueItem> items;

  factory Issues.fromJson(String str) => Issues.fromMap(json.decode(str));

  bool? get isNotEmpty => null;

  String toJson() => json.encode(toMap());

  factory Issues.fromMap(Map<String, dynamic> json) => Issues(
        totalCount: json["total_count"],
        incompleteResults: json["incomplete_results"],
        items: List<IssueItem>.from(
                json["items"].map((x) => IssueItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "total_count": totalCount,
        "incomplete_results":
            incompleteResults,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}
