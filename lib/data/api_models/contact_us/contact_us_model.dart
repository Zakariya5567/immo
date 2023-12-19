// To parse this JSON data, do
//
//     final contactUsModel = contactUsModelFromJson(jsonString);

import 'dart:convert';

ContactUsModel contactUsModelFromJson(String str) => ContactUsModel.fromJson(json.decode(str));

String contactUsModelToJson(ContactUsModel data) => json.encode(data.toJson());

class ContactUsModel {
    ContactUsModel({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    Data? data;

    factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
        error: json["error"],
        message: json["message"],
        data: json["data"] == null ? null :Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data == null? null : data!.toJson(),
    };
}

class Data {
    Data({
        this.firstName,
        this.lastName,
        this.gender,
        this.reason,
        this.telephoneNumber,
        this.email,
        this.message,
    });

    String? firstName;
    String? lastName;
    String? gender;
    String? reason;
    String? telephoneNumber;
    String? email;
    String? message;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        reason: json["reason"],
        telephoneNumber: json["telephone_number"],
        email: json["email"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "reason": reason,
        "telephone_number": telephoneNumber,
        "email": email,
        "message": message,
    };
}
