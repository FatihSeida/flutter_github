import 'dart:convert';

class User {
  User({
    required this.login,
    required this.avatarUrl,
    required this.url,
  });

  String login;
  String avatarUrl;
  String url;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        login: json["login"] == null ? null : json["login"],
        avatarUrl: json["avatar_url"] == null ? null : json["avatar_url"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toMap() => {
        "login": login,
        "avatar_url": avatarUrl,
        "url": url,
      };
}
