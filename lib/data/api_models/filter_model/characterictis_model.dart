// To parse this JSON data, do
//
//     final characteristicsModel = characteristicsModelFromJson(jsonString);

import 'dart:convert';

CharacteristicsModel characteristicsModelFromJson(String str) =>
    CharacteristicsModel.fromJson(json.decode(str));

String characteristicsModelToJson(CharacteristicsModel data) =>
    json.encode(data.toJson());

class CharacteristicsModel {
  CharacteristicsModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  List<Datum>? data;

  factory CharacteristicsModel.fromJson(Map<String, dynamic> json) =>
      CharacteristicsModel(
        error: json["error"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.key,
    this.title,
    this.type,
  });

  String? key;
  String? title;
  String? type;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        key: json["key"],
        title: json["title"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "title": title,
        "type": type,
      };
}

class CharacteristicsData {
  CharacteristicsData({
    this.key,
    this.title,
    this.type,
    this.isSelected,
  });

  String? key;
  String? title;
  String? type;
  bool? isSelected;
}
