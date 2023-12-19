// To parse this JSON data, do
//
//     final filterFloorListModel = filterFloorListModelFromJson(jsonString);

import 'dart:convert';

FilterFloorListModel filterFloorListModelFromJson(String str) =>
    FilterFloorListModel.fromJson(json.decode(str));

String filterFloorListModelToJson(FilterFloorListModel data) =>
    json.encode(data.toJson());

class FilterFloorListModel {
  FilterFloorListModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  Map<String, dynamic>? data;

  factory FilterFloorListModel.fromJson(Map<String, dynamic> json) =>
      FilterFloorListModel(
          error: json["error"], message: json["message"], data: json["data"]);

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data,
      };
}

class FloorSelectedData {
  String? key;
  String? value;
  bool? isSelected;
  FloorSelectedData(
      {required this.key, required this.value, required this.isSelected});
}
