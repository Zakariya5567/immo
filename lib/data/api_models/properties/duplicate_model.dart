// To parse this JSON data, do
//
//     final duplicateModel = duplicateModelFromJson(jsonString);

import 'dart:convert';

DuplicateModel duplicateModelFromJson(String str) =>
    DuplicateModel.fromJson(json.decode(str));

String duplicateModelToJson(DuplicateModel data) => json.encode(data.toJson());

class DuplicateModel {
  DuplicateModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  dynamic data;

  factory DuplicateModel.fromJson(Map<String, dynamic> json) => DuplicateModel(
        error: json["error"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data,
      };
}
