// To parse this JSON data, do
//
//     final savePdfModel = savePdfModelFromJson(jsonString);

import 'dart:convert';
import '/data/api_models/post_an_ad/file_data.Dart';
SavePdfModel savePdfModelFromJson(String str) =>
    SavePdfModel.fromJson(json.decode(str));

String savePdfModelToJson(SavePdfModel data) => json.encode(data.toJson());

class SavePdfModel {
  SavePdfModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  FileData? data;

  factory SavePdfModel.fromJson(Map<String, dynamic> json) => SavePdfModel(
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
