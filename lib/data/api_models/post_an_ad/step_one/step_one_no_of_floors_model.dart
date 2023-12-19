// To parse this JSON data, do
//
//     final noOfFloorsModel = noOfFloorsModelFromJson(jsonString);

import 'dart:convert';

NoOfFloorsModel noOfFloorsModelFromJson(String str) => NoOfFloorsModel.fromJson(json.decode(str));

String noOfFloorsModelToJson(NoOfFloorsModel data) => json.encode(data.toJson());

class NoOfFloorsModel {
    NoOfFloorsModel({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    Map<String, dynamic>? data;

    factory NoOfFloorsModel.fromJson(Map<String, dynamic> json) => NoOfFloorsModel(
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