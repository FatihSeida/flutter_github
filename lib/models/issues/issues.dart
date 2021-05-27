// To parse this JSON data, do
//
//     final issues = issuesFromMap(jsonString);

import 'dart:convert';

import '../user.dart';

part 'issueItem.dart';

class Issues {
  Issues({
    this.totalCount,
    this.incompleteResults,
    this.items,
  });

  int totalCount;
  bool incompleteResults;
  List<IssueItem> items;

  factory Issues.fromJson(String str) => Issues.fromMap(json.decode(str));

  bool get isNotEmpty => null;

  String toJson() => json.encode(toMap());

  factory Issues.fromMap(Map<String, dynamic> json) => Issues(
        totalCount: json["total_count"] == null ? null : json["total_count"],
        incompleteResults: json["incomplete_results"] == null
            ? null
            : json["incomplete_results"],
        items: json["items"] == null
            ? null
            : List<IssueItem>.from(
                json["items"].map((x) => IssueItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "total_count": totalCount == null ? null : totalCount,
        "incomplete_results":
            incompleteResults == null ? null : incompleteResults,
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toMap())),
      };
}
