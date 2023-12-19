// To parse this JSON data, do
//
//     final propertyCategoryModel = propertyCategoryModelFromJson(jsonString);

import 'dart:convert';

PropertyCategoryModel propertyCategoryModelFromJson(String str) =>
    PropertyCategoryModel.fromJson(json.decode(str));

String propertyCategoryModelToJson(PropertyCategoryModel data) =>
    json.encode(data.toJson());

class PropertyCategoryModel {
  PropertyCategoryModel({
    this.data,
    this.error,
    this.message,
  });

  List<CategoryData>? data;
  bool? error;
  String? message;

  factory PropertyCategoryModel.fromJson(Map<String, dynamic> json) =>
      PropertyCategoryModel(
        data: List<CategoryData>.from(
            json["data"].map((x) => CategoryData.fromJson(x))),
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "error": error,
        "message": message,
      };
}

class CategoryData {
  CategoryData({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
