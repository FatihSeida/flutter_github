import 'dart:convert';

import '/models/user.dart';

part 'repositoryItem.dart';

class Repositories {
  Repositories({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  int totalCount;
  bool incompleteResults;
  List<RepositoryItem> items;

  factory Repositories.fromJson(String str) =>
      Repositories.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Repositories.fromMap(Map<String, dynamic> json) => Repositories(
        totalCount: json["total_count"],
        incompleteResults: json["incomplete_results"],
        items: List<RepositoryItem>.from(
            json["items"].map((x) => RepositoryItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "total_count": totalCount,
        "incomplete_results": incompleteResults,
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}
