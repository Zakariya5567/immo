// To parse this JSON data, do
//
//     final adsWithModel = adsWithModelFromJson(jsonString);

import 'dart:convert';

AdsWithModel adsWithModelFromJson(String str) =>
    AdsWithModel.fromJson(json.decode(str));

String adsWithModelToJson(AdsWithModel data) => json.encode(data.toJson());

class AdsWithModel {
  AdsWithModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  Map<String, dynamic>? data;

  factory AdsWithModel.fromJson(Map<String, dynamic> json) => AdsWithModel(
      error: json["error"], message: json["message"], data: json["data"]);

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data,
      };
}

class AdsWithData {
  String? key;
  String? value;
  bool? isSelected;
  AdsWithData(
      {required this.key, required this.value, required this.isSelected});
}
