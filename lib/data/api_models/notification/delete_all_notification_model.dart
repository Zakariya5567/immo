// To parse this JSON data, do
//
//     final deleteAllNotificationModel = deleteAllNotificationModelFromJson(jsonString);

import 'dart:convert';

DeleteAllNotificationModel deleteAllNotificationModelFromJson(String str) =>
    DeleteAllNotificationModel.fromJson(json.decode(str));

String deleteAllNotificationModelToJson(DeleteAllNotificationModel data) =>
    json.encode(data.toJson());

class DeleteAllNotificationModel {
  DeleteAllNotificationModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  dynamic data;

  factory DeleteAllNotificationModel.fromJson(Map<String, dynamic> json) =>
      DeleteAllNotificationModel(
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
