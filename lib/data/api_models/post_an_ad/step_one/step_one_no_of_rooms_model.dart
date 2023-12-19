// To parse this JSON data, do
//
//     final noOfRoomsModel = noOfRoomsModelFromJson(jsonString);

import 'dart:convert';

NoOfRoomsModel noOfRoomsModelFromJson(String str) =>
    NoOfRoomsModel.fromJson(json.decode(str));

String noOfRoomsModelToJson(NoOfRoomsModel data) => json.encode(data.toJson());

class NoOfRoomsModel {
  NoOfRoomsModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  Map<String, dynamic>? data;

  factory NoOfRoomsModel.fromJson(Map<String, dynamic> json) => NoOfRoomsModel(
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
