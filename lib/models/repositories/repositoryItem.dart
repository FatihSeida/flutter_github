part of 'repositories.dart';

class RepositoryItem {
  RepositoryItem({
    this.name,
    this.owner,
    this.htmlUrl,
    this.createdAt,
    this.stargazersCount,
    this.watchersCount,
    this.forksCount,
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
        owner: json["owner"] == null ? null : User.fromMap(json["owner"]),
        htmlUrl: json["html_url"] == null ? null : json["html_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        stargazersCount:
            json["stargazers_count"] == null ? null : json["stargazers_count"],
        watchersCount:
            json["watchers_count"] == null ? null : json["watchers_count"],
        forksCount: json["forks_count"] == null ? null : json["forks_count"],
      );

  Map<String, dynamic> toMap() => {
        "full_name": name == null ? null : name,
        "owner": owner == null ? null : owner.toMap(),
        "html_url": htmlUrl == null ? null : htmlUrl,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "stargazers_count": stargazersCount == null ? null : stargazersCount,
        "watchers_count": watchersCount == null ? null : watchersCount,
        "forks_count": forksCount == null ? null : forksCount,
      };
}
