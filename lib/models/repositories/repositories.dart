import 'dart:convert';

import 'package:sejutacita_flutter_github/models/user.dart';

part 'repositoryItem.dart';

class Repositories {
  Repositories({
    this.totalCount,
    this.incompleteResults,
    this.items,
  });

  int totalCount;
  bool incompleteResults;
  List<RepositoryItem> items;

  factory Repositories.fromJson(String str) =>
      Repositories.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Repositories.fromMap(Map<String, dynamic> json) => Repositories(
        totalCount: json["total_count"] == null ? null : json["total_count"],
        incompleteResults: json["incomplete_results"] == null
            ? null
            : json["incomplete_results"],
        items: json["items"] == null
            ? null
            : List<RepositoryItem>.from(
                json["items"].map((x) => RepositoryItem.fromMap(x))),
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
