// To parse this JSON data, do
//
//     final reportAdModel = reportAdModelFromJson(jsonString);

import 'dart:convert';

ReportAdModel reportAdModelFromJson(String str) =>
    ReportAdModel.fromJson(json.decode(str));

String reportAdModelToJson(ReportAdModel data) => json.encode(data.toJson());

class ReportAdModel {
  ReportAdModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  Map<String, dynamic>? data;

  factory ReportAdModel.fromJson(Map<String, dynamic> json) => ReportAdModel(
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
