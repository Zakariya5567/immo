// To parse this JSON data, do
//
//     final emailAlreadyExistModel = emailAlreadyExistModelFromJson(jsonString);

import 'dart:convert';

EmailAlreadyExistModel emailAlreadyExistModelFromJson(String str) =>
    EmailAlreadyExistModel.fromJson(json.decode(str));

String emailAlreadyExistModelToJson(EmailAlreadyExistModel data) =>
    json.encode(data.toJson());

class EmailAlreadyExistModel {
  EmailAlreadyExistModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  dynamic data;

  factory EmailAlreadyExistModel.fromJson(Map<String, dynamic> json) =>
      EmailAlreadyExistModel(
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
