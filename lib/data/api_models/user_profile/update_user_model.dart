// To parse this JSON data, do
//
//     final updateUserModel = updateUserModelFromJson(jsonString);

import 'dart:convert';

UpdateUserModel? updateUserModelFromJson(String str) =>
    UpdateUserModel.fromJson(json.decode(str));

String updateUserModelToJson(UpdateUserModel? data) =>
    json.encode(data!.toJson());

class UpdateUserModel {
  UpdateUserModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  Data? data;

  factory UpdateUserModel.fromJson(Map<String, dynamic> json) =>
      UpdateUserModel(
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
  String? phoneNumber;
  String? address;
  String? location;
  String? website;
  dynamic isCompany;
  String? companyName;
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
