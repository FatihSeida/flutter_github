part of 'repositories.dart';

class RepositoryItem {
  RepositoryItem({
    required this.name,
    required this.owner,
    required this.htmlUrl,
    required this.createdAt,
    required this.stargazersCount,
    required this.watchersCount,
    required this.forksCount,
  });

  String name;
  User owner;
  String htmlUrl;
  DateTime createdAt;
  int stargazersCount;
  int watchersCount;
  int forksCount;

  factory RepositoryItem.fromJson(String str) =>
      RepositoryItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RepositoryItem.fromMap(Map<String, dynamic> json) => RepositoryItem(
        name: json["full_name"] == null ? null : json["full_name"],
        owner: User.fromMap(json["owner"]),
        htmlUrl: json["html_url"] == null ? null : json["html_url"],
        createdAt: DateTime.parse(json["created_at"]),
        stargazersCount:
            json["stargazers_count"] == null ? null : json["stargazers_count"],
        watchersCount:
            json["watchers_count"] == null ? null : json["watchers_count"],
        forksCount: json["forks_count"] == null ? null : json["forks_count"],
      );

  Map<String, dynamic> toMap() => {
        "full_name": name,
        "owner": owner.toMap(),
        "html_url": htmlUrl,
        "created_at": createdAt.toIso8601String(),
        "stargazers_count": stargazersCount,
        "watchers_count":watchersCount,
        "forks_count": forksCount,
      };
}
