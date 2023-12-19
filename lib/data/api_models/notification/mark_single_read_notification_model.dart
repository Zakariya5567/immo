// To parse this JSON data, do
//
//     final markSingleReadNotificationModel = markSingleReadNotificationModelFromJson(jsonString);

import 'dart:convert';

MarkSingleReadNotificationModel markSingleReadNotificationModelFromJson(
        String str) =>
    MarkSingleReadNotificationModel.fromJson(json.decode(str));

String markSingleReadNotificationModelToJson(
        MarkSingleReadNotificationModel data) =>
    json.encode(data.toJson());

class MarkSingleReadNotificationModel {
  MarkSingleReadNotificationModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  dynamic data;

  factory MarkSingleReadNotificationModel.fromJson(Map<String, dynamic> json) =>
      MarkSingleReadNotificationModel(
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
