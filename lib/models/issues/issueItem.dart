part of 'issues.dart';

class IssueItem {
  IssueItem({
    this.url,
    this.title,
    this.user,
    this.state,
    this.updatedAt,
  });

  String url;
  String title;
  User user;
  String state;
  DateTime updatedAt;

  factory IssueItem.fromJson(String str) => IssueItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IssueItem.fromMap(Map<String, dynamic> json) => IssueItem(
        url: json["url"] == null ? null : json["url"],
        title: json["title"] == null ? null : json["title"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
        state: json["state"] == null ? null : json["state"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "url": url == null ? null : url,
        "title": title == null ? null : title,
        "user": user == null ? null : user.toMap(),
        "state": state == null ? null : state,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
