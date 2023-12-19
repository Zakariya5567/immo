// To parse this JSON data, do
//
//     final contactUsDetailModel = contactUsDetailModelFromJson(jsonString);

import 'dart:convert';

ContactUsDetailModel contactUsDetailModelFromJson(String str) => ContactUsDetailModel.fromJson(json.decode(str));

String contactUsDetailModelToJson(ContactUsDetailModel data) => json.encode(data.toJson());

class ContactUsDetailModel {
    ContactUsDetailModel({
        this.error,
        this.message,
        this.ownerDetail,
    });

    bool? error;
    String? message;
    OwnerDetail? ownerDetail;

    factory ContactUsDetailModel.fromJson(Map<String, dynamic> json) => ContactUsDetailModel(
        error: json["error"],
        message: json["message"],
        ownerDetail: json["data"] == null ? null : OwnerDetail.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": ownerDetail?.toJson(),
    };
}

class OwnerDetail {
    OwnerDetail({
        this.email,
        this.phoneNumber,
        this.address,
        this.location,
        this.lat,
        this.lng,
    });

    String? email;
    String? phoneNumber;
    String? address;
    String? location;
    String? lat;
    String? lng;

    factory OwnerDetail.fromJson(Map<String, dynamic> json) => OwnerDetail(
        email: json["email"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        location: json["location"],
        lat: json["lat"],
        lng: json["lng"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "location": location,
        "lat": lat,
        "lng": lng,
    };
}
