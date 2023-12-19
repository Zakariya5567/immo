// To parse this JSON data, do
//
//     final deleteFileModel = deleteFileModelFromJson(jsonString);

import 'dart:convert';

DeleteFileModel deleteFileModelFromJson(String str) => DeleteFileModel.fromJson(json.decode(str));

String deleteFileModelToJson(DeleteFileModel data) => json.encode(data.toJson());

class DeleteFileModel {
    DeleteFileModel({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    dynamic data;

    factory DeleteFileModel.fromJson(Map<String, dynamic> json) => DeleteFileModel(
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
