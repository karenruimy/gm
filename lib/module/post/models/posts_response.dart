// To parse this JSON data, do
//
//     final postsResponseModel = postsResponseModelFromJson(jsonString);

import 'dart:convert';

List<PostModel> postsResponseModelFromJson(dynamic json) => List<PostModel>.from(json.map((x) => PostModel.fromJson(x)));

String postsResponseModelToJson(List<PostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

PostModel postModelFromJson(dynamic json) => PostModel.fromJson(json);

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  int id;
  String slug;
  String status;
  String type;
  String link;
  Title title;
  Content content;
  Excerpt excerpt;
  int author;
  int featuredMedia;
  String commentStatus;
  String pingStatus;
  bool sticky;
  String template;
  String format;
  YoastHeadJson yoastHeadJson;
  List<int> categories;


  PostModel({
    required this.id,
    required this.slug,
    required this.status,
    required this.type,
    required this.link,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.author,
    required this.featuredMedia,
    required this.commentStatus,
    required this.pingStatus,
    required this.sticky,
    required this.template,
    required this.format,
    required this.yoastHeadJson,
    required this.categories,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json["id"],
    slug: json["slug"],
    status: json["status"],
    type: json["type"],
    link: json["link"],
    title: Title.fromJson(json["title"]),
    content: Content.fromJson(json["content"]),
    excerpt: Excerpt.fromJson(json["excerpt"]),
    author: json["author"],
    featuredMedia: json["featured_media"],
    commentStatus: json["comment_status"],
    pingStatus: json["ping_status"],
    sticky: json["sticky"],
    template: json["template"],
    format: json["format"],
    yoastHeadJson: YoastHeadJson.fromJson(json["yoast_head_json"]),
    categories: List<int>.from(json["categories"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "status": status,
    "type": type,
    "link": link,
    "title": title.toJson(),
    "content": content.toJson(),
    "excerpt": excerpt.toJson(),
    "author": author,
    "featured_media": featuredMedia,
    "comment_status": commentStatus,
    "ping_status": pingStatus,
    "sticky": sticky,
    "template": template,
    "format": format,
    "yoast_head_json": yoastHeadJson.toJson(),
    "categories": List<dynamic>.from(categories.map((x) => x)),
  };
}

class Content {
  String rendered;
  bool protected;

  Content({
    required this.rendered,
    required this.protected,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    rendered: json["rendered"],
    protected: json["protected"],
  );

  Map<String, dynamic> toJson() => {
    "rendered": rendered,
    "protected": protected,
  };
}
class Excerpt {
  String rendered;
  bool protected;

  Excerpt({
    required this.rendered,
    required this.protected,
  });

  factory Excerpt.fromJson(Map<String, dynamic> json) => Excerpt(
    rendered: json["rendered"],
    protected: json["protected"],
  );

  Map<String, dynamic> toJson() => {
    "rendered": rendered,
    "protected": protected,
  };
}
class Title {
  String rendered;

  Title({
    required this.rendered,
  });

  factory Title.fromJson(Map<String, dynamic> json) => Title(
    rendered: json["rendered"],
  );

  Map<String, dynamic> toJson() => {
    "rendered": rendered,
  };
}

class YoastHeadJson {
  String title;
  String ogDescription;
  String ogUrl;
  String ogSiteName;
  List<OgImage> ogImage;
  String author;

  YoastHeadJson({
    required this.title,
    required this.ogDescription,
    required this.ogUrl,
    required this.ogSiteName,
    required this.ogImage,
    required this.author,
  });

  factory YoastHeadJson.fromJson(Map<String, dynamic> json) => YoastHeadJson(
    title: json["title"],
    ogDescription: json["og_description"],
    ogUrl: json["og_url"],
    ogSiteName: json["og_site_name"],
    ogImage: List<OgImage>.from(json["og_image"].map((x) => OgImage.fromJson(x))),
    author: json["author"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "og_description": ogDescription,
    "og_url": ogUrl,
    "og_site_name": ogSiteName,
    "og_image": List<dynamic>.from(ogImage.map((x) => x.toJson())),
    "author": author,
  };
}

class OgImage {
  int width;
  int height;
  String url;
  String type;

  OgImage({
    required this.width,
    required this.height,
    required this.url,
    required this.type,
  });

  factory OgImage.fromJson(Map<String, dynamic> json) => OgImage(
    width: json["width"],
    height: json["height"],
    url: json["url"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "width": width,
    "height": height,
    "url": url,
    "type": type,
  };
}