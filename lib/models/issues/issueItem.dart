part of 'issues.dart';

class IssueItem {
  IssueItem({
    required this.url,
    required this.title,
    required this.user,
    required this.state,
    required this.updatedAt,
  });

  String url;
  String title;
  User user;
  String state;
  DateTime updatedAt;

  factory IssueItem.fromJson(String str) => IssueItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IssueItem.fromMap(Map<String, dynamic> json) => IssueItem(
        url: json["url"],
        title: json["title"],
        user: User.fromMap(json["user"]),
        state: json["state"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "title": title,
        "user": user.toMap(),
        "state": state,
        "updated_at": updatedAt.toIso8601String(),
      };
}
