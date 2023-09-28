// To parse this JSON data, do
//
//     final categoryResponseModel = categoryResponseModelFromJson(jsonString);

import 'dart:convert';

List<CategoryModel> categoryResponseModelFromJson(dynamic json) => List<CategoryModel>.from(json.map((x) => CategoryModel.fromJson(x)));

String categoryResponseModelToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  int id;
  int count;
  String description;
  String link;
  String name;
  String slug;
  String taxonomy;
  int parent;
  List<dynamic> meta;
  String yoastHead;
  YoastHeadJson yoastHeadJson;
  Links links;

  CategoryModel({
    required this.id,
    required this.count,
    required this.description,
    required this.link,
    required this.name,
    required this.slug,
    required this.taxonomy,
    required this.parent,
    required this.meta,
    required this.yoastHead,
    required this.yoastHeadJson,
    required this.links,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    count: json["count"],
    description: json["description"],
    link: json["link"],
    name: json["name"],
    slug: json["slug"],
    taxonomy: json["taxonomy"],
    parent: json["parent"],
    meta: List<dynamic>.from(json["meta"].map((x) => x)),
    yoastHead: json["yoast_head"],
    yoastHeadJson: YoastHeadJson.fromJson(json["yoast_head_json"]),
    links: Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "count": count,
    "description": description,
    "link": link,
    "name": name,
    "slug": slug,
    "taxonomy": taxonomy,
    "parent": parent,
    "meta": List<dynamic>.from(meta.map((x) => x)),
    "yoast_head": yoastHead,
    "yoast_head_json": yoastHeadJson.toJson(),
    "_links": links.toJson(),
  };
}

class Links {
  List<About> self;
  List<About> collection;
  List<About> about;
  List<About> wpPostType;
  List<Cury> curies;

  Links({
    required this.self,
    required this.collection,
    required this.about,
    required this.wpPostType,
    required this.curies,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
    collection: List<About>.from(json["collection"].map((x) => About.fromJson(x))),
    about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
    wpPostType: List<About>.from(json["wp:post_type"].map((x) => About.fromJson(x))),
    curies: List<Cury>.from(json["curies"].map((x) => Cury.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "self": List<dynamic>.from(self.map((x) => x.toJson())),
    "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
    "about": List<dynamic>.from(about.map((x) => x.toJson())),
    "wp:post_type": List<dynamic>.from(wpPostType.map((x) => x.toJson())),
    "curies": List<dynamic>.from(curies.map((x) => x.toJson())),
  };
}

class About {
  String href;

  About({
    required this.href,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}

class Cury {
  String name;
  String href;
  bool templated;

  Cury({
    required this.name,
    required this.href,
    required this.templated,
  });

  factory Cury.fromJson(Map<String, dynamic> json) => Cury(
    name: json["name"],
    href: json["href"],
    templated: json["templated"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "href": href,
    "templated": templated,
  };
}

class YoastHeadJson {
  String title;
  Robots robots;
  String ogLocale;
  String ogType;
  String ogTitle;
  String ogUrl;
  String ogSiteName;
  String twitterCard;
  Schema schema;

  YoastHeadJson({
    required this.title,
    required this.robots,
    required this.ogLocale,
    required this.ogType,
    required this.ogTitle,
    required this.ogUrl,
    required this.ogSiteName,
    required this.twitterCard,
    required this.schema,
  });

  factory YoastHeadJson.fromJson(Map<String, dynamic> json) => YoastHeadJson(
    title: json["title"],
    robots: Robots.fromJson(json["robots"]),
    ogLocale: json["og_locale"],
    ogType: json["og_type"],
    ogTitle: json["og_title"],
    ogUrl: json["og_url"],
    ogSiteName: json["og_site_name"],
    twitterCard: json["twitter_card"],
    schema: Schema.fromJson(json["schema"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "robots": robots.toJson(),
    "og_locale": ogLocale,
    "og_type": ogType,
    "og_title": ogTitle,
    "og_url": ogUrl,
    "og_site_name": ogSiteName,
    "twitter_card": twitterCard,
    "schema": schema.toJson(),
  };
}

class Robots {
  String index;
  String follow;
  String maxSnippet;
  String maxImagePreview;
  String maxVideoPreview;

  Robots({
    required this.index,
    required this.follow,
    required this.maxSnippet,
    required this.maxImagePreview,
    required this.maxVideoPreview,
  });

  factory Robots.fromJson(Map<String, dynamic> json) => Robots(
    index: json["index"],
    follow: json["follow"],
    maxSnippet: json["max-snippet"],
    maxImagePreview: json["max-image-preview"],
    maxVideoPreview: json["max-video-preview"],
  );

  Map<String, dynamic> toJson() => {
    "index": index,
    "follow": follow,
    "max-snippet": maxSnippet,
    "max-image-preview": maxImagePreview,
    "max-video-preview": maxVideoPreview,
  };
}

class Schema {
  String context;
  List<Graph> graph;

  Schema({
    required this.context,
    required this.graph,
  });

  factory Schema.fromJson(Map<String, dynamic> json) => Schema(
    context: json["@context"],
    graph: List<Graph>.from(json["@graph"].map((x) => Graph.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "@context": context,
    "@graph": List<dynamic>.from(graph.map((x) => x.toJson())),
  };
}

class Graph {
  String type;
  String id;
  String? url;
  String? name;
  Breadcrumb? isPartOf;
  Breadcrumb? breadcrumb;
  String? inLanguage;
  List<ItemListElement>? itemListElement;
  String? description;
  Breadcrumb? publisher;
  List<PotentialAction>? potentialAction;
  Logo? logo;
  Breadcrumb? image;

  Graph({
    required this.type,
    required this.id,
    this.url,
    this.name,
    this.isPartOf,
    this.breadcrumb,
    this.inLanguage,
    this.itemListElement,
    this.description,
    this.publisher,
    this.potentialAction,
    this.logo,
    this.image,
  });

  factory Graph.fromJson(Map<String, dynamic> json) => Graph(
    type: json["@type"],
    id: json["@id"],
    url: json["url"],
    name: json["name"],
    isPartOf: json["isPartOf"] == null ? null : Breadcrumb.fromJson(json["isPartOf"]),
    breadcrumb: json["breadcrumb"] == null ? null : Breadcrumb.fromJson(json["breadcrumb"]),
    inLanguage: json["inLanguage"],
    itemListElement: json["itemListElement"] == null ? [] : List<ItemListElement>.from(json["itemListElement"]!.map((x) => ItemListElement.fromJson(x))),
    description: json["description"],
    publisher: json["publisher"] == null ? null : Breadcrumb.fromJson(json["publisher"]),
    potentialAction: json["potentialAction"] == null ? [] : List<PotentialAction>.from(json["potentialAction"]!.map((x) => PotentialAction.fromJson(x))),
    logo: json["logo"] == null ? null : Logo.fromJson(json["logo"]),
    image: json["image"] == null ? null : Breadcrumb.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "@type": type,
    "@id": id,
    "url": url,
    "name": name,
    "isPartOf": isPartOf?.toJson(),
    "breadcrumb": breadcrumb?.toJson(),
    "inLanguage": inLanguage,
    "itemListElement": itemListElement == null ? [] : List<dynamic>.from(itemListElement!.map((x) => x.toJson())),
    "description": description,
    "publisher": publisher?.toJson(),
    "potentialAction": potentialAction == null ? [] : List<dynamic>.from(potentialAction!.map((x) => x.toJson())),
    "logo": logo?.toJson(),
    "image": image?.toJson(),
  };
}

class Breadcrumb {
  String id;

  Breadcrumb({
    required this.id,
  });

  factory Breadcrumb.fromJson(Map<String, dynamic> json) => Breadcrumb(
    id: json["@id"],
  );

  Map<String, dynamic> toJson() => {
    "@id": id,
  };
}

class ItemListElement {
  String type;
  int position;
  String name;
  String? item;

  ItemListElement({
    required this.type,
    required this.position,
    required this.name,
    this.item,
  });

  factory ItemListElement.fromJson(Map<String, dynamic> json) => ItemListElement(
    type: json["@type"],
    position: json["position"],
    name: json["name"],
    item: json["item"],
  );

  Map<String, dynamic> toJson() => {
    "@type": type,
    "position": position,
    "name": name,
    "item": item,
  };
}

class Logo {
  String type;
  String inLanguage;
  String id;
  String url;
  String contentUrl;
  int width;
  int height;
  String caption;

  Logo({
    required this.type,
    required this.inLanguage,
    required this.id,
    required this.url,
    required this.contentUrl,
    required this.width,
    required this.height,
    required this.caption,
  });

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
    type: json["@type"],
    inLanguage: json["inLanguage"],
    id: json["@id"],
    url: json["url"],
    contentUrl: json["contentUrl"],
    width: json["width"],
    height: json["height"],
    caption: json["caption"],
  );

  Map<String, dynamic> toJson() => {
    "@type": type,
    "inLanguage": inLanguage,
    "@id": id,
    "url": url,
    "contentUrl": contentUrl,
    "width": width,
    "height": height,
    "caption": caption,
  };
}

class PotentialAction {
  String type;
  Target target;
  String queryInput;

  PotentialAction({
    required this.type,
    required this.target,
    required this.queryInput,
  });

  factory PotentialAction.fromJson(Map<String, dynamic> json) => PotentialAction(
    type: json["@type"],
    target: Target.fromJson(json["target"]),
    queryInput: json["query-input"],
  );

  Map<String, dynamic> toJson() => {
    "@type": type,
    "target": target.toJson(),
    "query-input": queryInput,
  };
}

class Target {
  String type;
  String urlTemplate;

  Target({
    required this.type,
    required this.urlTemplate,
  });

  factory Target.fromJson(Map<String, dynamic> json) => Target(
    type: json["@type"],
    urlTemplate: json["urlTemplate"],
  );

  Map<String, dynamic> toJson() => {
    "@type": type,
    "urlTemplate": urlTemplate,
  };
}
