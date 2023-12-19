// To parse this JSON data, do
//
//     final publishadModel = publishadModelFromJson(jsonString);

import 'dart:convert';

PublishadModel publishadModelFromJson(String str) => PublishadModel.fromJson(json.decode(str));

String publishadModelToJson(PublishadModel data) => json.encode(data.toJson());

class PublishadModel {
    PublishadModel({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    dynamic data;

    factory PublishadModel.fromJson(Map<String, dynamic> json) => PublishadModel(
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
