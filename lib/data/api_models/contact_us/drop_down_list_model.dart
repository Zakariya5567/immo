// To parse this JSON data, do
//
//     final dropDownListModel = dropDownListModelFromJson(jsonString);

import 'dart:convert';

ContactUSDropDownListModel? dropDownListModelFromJson(String str) =>
    ContactUSDropDownListModel.fromJson(json.decode(str));

String dropDownListModelToJson(ContactUSDropDownListModel? data) =>
    json.encode(data!.toJson());

class ContactUSDropDownListModel {
  ContactUSDropDownListModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  Map<String, dynamic>? data;

  factory ContactUSDropDownListModel.fromJson(Map<String, dynamic> json) =>
      ContactUSDropDownListModel(
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
