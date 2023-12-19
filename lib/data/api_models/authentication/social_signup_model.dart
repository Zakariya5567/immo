// To parse this JSON data, do
//
//     final socialSignUpModel = socialSignUpModelFromJson(jsonString);

import 'dart:convert';

SocialSignUpModel? socialSignUpModelFromJson(String str) =>
    SocialSignUpModel.fromJson(json.decode(str));

String socialSignUpModelToJson(SocialSignUpModel? data) =>
    json.encode(data!.toJson());

class SocialSignUpModel {
  SocialSignUpModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  Data? data;

  factory SocialSignUpModel.fromJson(Map<String, dynamic> json) =>
      SocialSignUpModel(
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
    this.token,
    this.user,
  });

  String? token;
  User? user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user == null ? null : user!.toJson(),
      };
}

class User {
  User({
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
  dynamic address;
  dynamic location;
  dynamic website;
  int? isCompany;
  dynamic companyName;
  int? status;
  String? avatar;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
