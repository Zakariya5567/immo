// To parse this JSON data, do
//
//     final ageOfAdModel = ageOfAdModelFromJson(jsonString);

import 'dart:convert';

AgeOfAdModel ageOfAdModelFromJson(String str) =>
    AgeOfAdModel.fromJson(json.decode(str));

String ageOfAdModelToJson(AgeOfAdModel data) => json.encode(data.toJson());

class AgeOfAdModel {
  AgeOfAdModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  Map<String, dynamic>? data;

  factory AgeOfAdModel.fromJson(Map<String, dynamic> json) => AgeOfAdModel(
      error: json["error"], message: json["message"], data: json["data"]);

  Map<String, dynamic> toJson() =>
      {"error": error, "message": message, "data": data};
}

class AgeOfAdData {
  String? key;
  String? value;
  bool? isSelected;
  AgeOfAdData(
      {required this.key, required this.value, required this.isSelected});
}
