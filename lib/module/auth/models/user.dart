// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(dynamic json) => User.fromJson(json);

String userToJson(User data) => json.encode(data.toJson());

List<User> userListModelFromJson(dynamic json) => List<User>.from(json.map((x) => User.fromJson(x)));

String userListModelToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class User {
  int id;
  String name;
  String url;
  String description;
  Map<String, String> avatarUrls;

  User({
    required this.id,
    required this.name,
    required this.url,
    required this.description,
    required this.avatarUrls,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    url: json["url"],
    description: json["description"],
    avatarUrls: Map.from(json["avatar_urls"]).map((k, v) => MapEntry<String, String>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
    "description": description,
    "avatar_urls": Map.from(avatarUrls).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
  static User empty = User(id: -1, name: '', url: '', description: '', avatarUrls: {},  );
}

