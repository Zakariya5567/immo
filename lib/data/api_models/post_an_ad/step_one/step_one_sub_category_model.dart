// To parse this JSON data, do
//
//     final propertySubCategoryModel = propertySubCategoryModelFromJson(jsonString);

import 'dart:convert';

PropertySubCategoryModel propertySubCategoryModelFromJson(String str) => PropertySubCategoryModel.fromJson(json.decode(str));

String propertySubCategoryModelToJson(PropertySubCategoryModel data) => json.encode(data.toJson());

class PropertySubCategoryModel {
    PropertySubCategoryModel({
        this.data,
        this.error,
        this.message,
    });

    List<Datum>? data;
    bool? error;
    String? message;

    factory PropertySubCategoryModel.fromJson(Map<String, dynamic> json) => PropertySubCategoryModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "error": error,
        "message": message,
    };
}

class Datum {
    Datum({
        required this.id,
        required this.title,
    });

    int id;
    String title;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
    };
}
