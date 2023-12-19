// To parse this JSON data, do
//
//     final saveImageModel = saveImageModelFromJson(jsonString);

import 'dart:convert';
import '/data/api_models/post_an_ad/file_data.Dart';
SaveImageModel saveImageModelFromJson(String str) =>
    SaveImageModel.fromJson(json.decode(str));

String saveImageModelToJson(SaveImageModel data) => json.encode(data.toJson());

class SaveImageModel {
  SaveImageModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  FileData? data;

  factory SaveImageModel.fromJson(Map<String, dynamic> json) => SaveImageModel(
        error: json["error"],
        message: json["message"],
        data: json["data"] == null ? null : FileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data?.toJson(),
      };
}
