// To parse this JSON data, do
//
//     final blog = blogFromJson(jsonString);
// Blog blogFromJson(String str) => Blog.fromJson(json.decode(str));
// String blogToJson(Blog data) => json.encode(data.toJson());

// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  int postId;
  int creationTimestamp;
  String title;
  String postLink;
  String picPath;
  String postText;
  int numberOfReadings;
  int categoryId;

  Post({
    required this.postId,
    required this.creationTimestamp,
    required this.title,
    required this.postLink,
    required this.picPath,
    required this.postText,
    required this.numberOfReadings,
    required this.categoryId,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    postId: int.parse(json["postId"]),
    creationTimestamp: json["creationTimestamp"],
    title: json["title"],
    postLink: json["postLink"],
    picPath: json["picPath"],
    postText: json["postText"],
    numberOfReadings: int.parse(json["numberOfReadings"]),
    categoryId: int.parse(json["categoryId"]),
  );

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "creationTimestamp": creationTimestamp,
    "title": title,
    "postLink": postLink,
    "picPath": picPath,
    "postText": postText,
    "numberOfReadings": numberOfReadings,
    "categoryId": categoryId,
  };
}
