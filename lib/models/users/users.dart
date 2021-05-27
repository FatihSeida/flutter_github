import 'dart:convert';

import 'package:sejutacita_flutter_github/models/user.dart';

class Users {
  Users({
    this.totalCount,
    this.incompleteResults,
    this.items,
  });

  int totalCount;
  bool incompleteResults;
  List<User> items;

  Users copyWith({
    int totalCount,
    bool incompleteResults,
    List<User> items,
  }) =>
      Users(
        totalCount: totalCount ?? this.totalCount,
        incompleteResults: incompleteResults ?? this.incompleteResults,
        items: items ?? this.items,
      );

  factory Users.fromJson(String str) => Users.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        totalCount: json["total_count"] == null ? null : json["total_count"],
        incompleteResults: json["incomplete_results"] == null
            ? null
            : json["incomplete_results"],
        items: json["items"] == null
            ? null
            : List<User>.from(json["items"].map((x) => User.fromMap(x))),
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
