// To parse this JSON data, do
//
//     final deleteAlertModel = deleteAlertModelFromJson(jsonString);

import 'dart:convert';

DeleteAlertModel deleteAlertModelFromJson(String str) =>
    DeleteAlertModel.fromJson(json.decode(str));

String deleteAlertModelToJson(DeleteAlertModel data) =>
    json.encode(data.toJson());

class DeleteAlertModel {
  DeleteAlertModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  dynamic data;

  factory DeleteAlertModel.fromJson(Map<String, dynamic> json) =>
      DeleteAlertModel(
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
