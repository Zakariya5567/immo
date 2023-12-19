// To parse this JSON data, do
//
//     final deleteAccountModel = deleteAccountModelFromJson(jsonString);

import 'dart:convert';

DeleteAccountModel deleteAccountModelFromJson(String str) =>
    DeleteAccountModel.fromJson(json.decode(str));

String deleteAccountModelToJson(DeleteAccountModel data) =>
    json.encode(data.toJson());

class DeleteAccountModel {
  bool? error;
  String? message;
  dynamic data;
  dynamic errors;

  DeleteAccountModel({
    this.error,
    this.message,
    this.data,
    this.errors,
  });

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) =>
      DeleteAccountModel(
        error: json["error"],
        message: json["message"],
        data: json["data"],
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data,
        "errors": errors,
      };
}
