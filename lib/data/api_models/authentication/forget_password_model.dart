// To parse this JSON data, do
//
//     final forgetPassswordModel = forgetPassswordModelFromJson(jsonString);

import 'dart:convert';

ForgetPasswordModel? forgetPassswordModelFromJson(String str) => ForgetPasswordModel.fromJson(json.decode(str));

String forgetPassswordModelToJson(ForgetPasswordModel? data) => json.encode(data!.toJson());

class ForgetPasswordModel {
    ForgetPasswordModel({
        this.error,
        this.message,
    });

    bool? error;
    String? message;

    factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) => ForgetPasswordModel(
        error: json["error"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
    };
}
