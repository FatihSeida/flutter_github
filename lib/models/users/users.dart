import 'dart:convert';

import '/models/user.dart';

class Users {
  Users({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  int totalCount;
  bool incompleteResults;
  List<User> items;

  Users copyWith({
    required int totalCount,
    required bool incompleteResults,
    required List<User> items,
  }) =>
      Users(
        totalCount: totalCount,
        incompleteResults: incompleteResults,
        items: items,
      );

  factory Users.fromJson(String str) => Users.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        totalCount: json["total_count"],
        incompleteResults: json["incomplete_results"],
        items: List<User>.from(json["items"].map((x) => User.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "total_count": totalCount,
        "incomplete_results": incompleteResults,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}
