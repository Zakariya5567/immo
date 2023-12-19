// To parse this JSON data, do
//
//     final createAlertModel = createAlertModelFromJson(jsonString);

import 'dart:convert';

CreateAlertModel createAlertModelFromJson(String str) =>
    CreateAlertModel.fromJson(json.decode(str));

String createAlertModelToJson(CreateAlertModel data) =>
    json.encode(data.toJson());

class CreateAlertModel {
  CreateAlertModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  Data? data;

  factory CreateAlertModel.fromJson(Map<String, dynamic> json) =>
      CreateAlertModel(
        error: json["error"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
  });

  int? id;
  String? name;
  String? email;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}
