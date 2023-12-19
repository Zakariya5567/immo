// To parse this JSON data, do
//
//     final currentUserModel = currentUserModelFromJson(jsonString);

import 'dart:convert';

CurrentUserModel? currentUserModelFromJson(String str) =>
    CurrentUserModel.fromJson(json.decode(str));

String currentUserModelToJson(CurrentUserModel? data) =>
    json.encode(data!.toJson());

class CurrentUserModel {
  CurrentUserModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  Data? data;

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) =>
      CurrentUserModel(
        error: json["error"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.username,
    this.email,
    this.phoneNumber,
    this.address,
    this.location,
    this.website,
    this.isCompany,
    this.companyName,
    this.status,
    this.avatar,
  });

  int? id;
  String? username;
  String? email;
  dynamic phoneNumber;
  String? address;
  String? location;
  dynamic website;
  int? isCompany;
  dynamic companyName;
  int? status;
  String? avatar;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        location: json["location"],
        website: json["website"],
        isCompany: json["is_company"],
        companyName: json["company_name"],
        status: json["status"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "location": location,
        "website": website,
        "is_company": isCompany,
        "company_name": companyName,
        "status": status,
        "avatar": avatar,
      };
}
