// To parse this JSON data, do
//
//     final saveContactFormModel = saveContactFormModelFromJson(jsonString);

import 'dart:convert';

SaveContactFormModel saveContactFormModelFromJson(String str) => SaveContactFormModel.fromJson(json.decode(str));

String saveContactFormModelToJson(SaveContactFormModel data) => json.encode(data.toJson());

class SaveContactFormModel {
    SaveContactFormModel({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    Data? data;

    factory SaveContactFormModel.fromJson(Map<String, dynamic> json) => SaveContactFormModel(
        error: json["error"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    Data({
        this.id,
        this.propertyId,
        this.contactFormType,
        this.email,
        this.telephoneNumber,
        this.contactPerson,
        this.comment,
    });

    int? id;
    int? propertyId;
    String? contactFormType;
    String? email;
    String? telephoneNumber;
    String? contactPerson;
    String? comment;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        propertyId: json["property_id"],
        contactFormType: json["contact_form_type"],
        email: json["email"],
        telephoneNumber: json["telephone_number"],
        contactPerson: json["contact_person"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "property_id": propertyId,
        "contact_form_type": contactFormType,
        "email": email,
        "telephone_number": telephoneNumber,
        "contact_person": contactPerson,
        "comment": comment,
    };
}
