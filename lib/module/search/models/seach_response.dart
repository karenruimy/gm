// To parse this JSON data, do
//
//     final searchPostModel = searchPostModelFromJson(jsonString);

import 'dart:convert';

List<SearchPostModel> searchPostModelFromJson(dynamic json) => List<SearchPostModel>.from(json.map((x) => SearchPostModel.fromJson(x)));

String searchPostModelToJson(List<SearchPostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchPostModel {
  int id;
  String title;
  String url;
  String type;
  String subtype;

  SearchPostModel({
    required this.id,
    required this.title,
    required this.url,
    required this.type,
    required this.subtype,
  });

  factory SearchPostModel.fromJson(Map<String, dynamic> json) => SearchPostModel(
    id: json["id"],
    title: json["title"],
    url: json["url"],
    type: json["type"],
    subtype: json["subtype"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url": url,
    "type": type,
    "subtype": subtype,
  };
}
