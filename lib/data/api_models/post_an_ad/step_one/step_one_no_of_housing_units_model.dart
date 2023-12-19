// To parse this JSON data, do
//
//     final noOfHousingUnitsModel = noOfHousingUnitsModelFromJson(jsonString);

import 'dart:convert';

NoOfHousingUnitsModel noOfHousingUnitsModelFromJson(String str) => NoOfHousingUnitsModel.fromJson(json.decode(str));

String noOfHousingUnitsModelToJson(NoOfHousingUnitsModel data) => json.encode(data.toJson());

class NoOfHousingUnitsModel {
    NoOfHousingUnitsModel({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    Map<String, dynamic>? data;

    factory NoOfHousingUnitsModel.fromJson(Map<String, dynamic> json) => NoOfHousingUnitsModel(
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