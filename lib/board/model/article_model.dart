// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'dart:convert';

articleModel articleModelFromJson(String str) =>
    articleModel.fromJson(json.decode(str));

String articleModelToJson(articleModel data) => json.encode(data.toJson());

class articleModel {
  articleModel({
    this.id,
    this.aptKaptCode,
    this.userId,
    this.nickname,
    this.category,
    this.title,
    this.content,
    this.views,
    this.likes,
    this.iLike,
    this.createdAt,
    this.updatedAt,
    this.contents,
  });

  int id;
  String aptKaptCode;
  int userId;
  String nickname;
  int category;
  String title;
  dynamic content;
  int views;
  String likes;
  dynamic iLike;
  DateTime createdAt;
  DateTime updatedAt;
  List<Content> contents;

  factory articleModel.fromJson(Map<String, dynamic> json) => articleModel(
        id: json["id"],
        aptKaptCode: json["aptKaptCode"],
        userId: json["userId"],
        nickname: json["nickname"],
        category: json["category"],
        title: json["title"],
        content: json["content"],
        views: json["views"],
        likes: json["likes"],
        iLike: json["iLike"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        contents: List<Content>.from(
            json["contents"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "aptKaptCode": aptKaptCode,
        "userId": userId,
        "nickname": nickname,
        "category": category,
        "title": title,
        "content": content,
        "views": views,
        "likes": likes,
        "iLike": iLike,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
      };
}

class Content {
  Content({
    this.contentType,
    this.content,
  });

  String contentType;
  String content;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        contentType: json["contentType"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "contentType": contentType,
        "content": content,
      };
}
