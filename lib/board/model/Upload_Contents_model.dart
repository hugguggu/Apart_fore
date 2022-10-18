// To parse this JSON data, do
//
//     final uploadContentsModel = uploadContentsModelFromJson(jsonString);

import 'dart:convert';

import 'package:apart_forest/board/model/article_model.dart';

UploadContentsModel uploadContentsModelFromJson(String str) =>
    UploadContentsModel.fromJson(json.decode(str));

String uploadContentsModelToJson(UploadContentsModel data) =>
    json.encode(data.toJson());

class UploadContentsModel {
  UploadContentsModel({
    this.category,
    this.title,
    this.contents,
  });

  int category;
  String title;
  List<Content> contents;

  factory UploadContentsModel.fromJson(Map<String, dynamic> json) =>
      UploadContentsModel(
        category: json["category"],
        title: json["title"],
        contents: List<Content>.from(
            json["contents"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "title": title,
        "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
      };
}

// class Content {
//   Content({
//     this.contentType,
//     this.content,
//   });

//   String contentType;
//   String content;

//   factory Content.fromJson(Map<String, dynamic> json) => Content(
//         contentType: json["contentType"],
//         content: json["content"],
//       );

//   Map<String, dynamic> toJson() => {
//         'contentType': contentType,
//         'content': content,
//       };
// }
