// To parse this JSON data, do
//
//     final saveDocModel = saveDocModelFromJson(jsonString);

import 'dart:convert';

SaveDocModel saveDocModelFromJson(String str) =>
    SaveDocModel.fromJson(json.decode(str));

String saveDocModelToJson(SaveDocModel data) => json.encode(data.toJson());

class SaveDocModel {
  SaveDocModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  Data? data;

  factory SaveDocModel.fromJson(Map<String, dynamic> json) => SaveDocModel(
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
    this.youtubeVideos,
    this.virtualTourLink,
  });

  List? youtubeVideos;
  String? virtualTourLink;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        youtubeVideos: json["youtube_videos"] == null
            ? [null, null]
            : List.from(json["youtube_videos"]!.map((x) => x)),
        virtualTourLink: json["virtual_tour_link"],
      );

  Map<String, dynamic> toJson() => {
        "youtube_videos": youtubeVideos == null
            ? [null, null]
            : List<dynamic>.from(youtubeVideos!.map((x) => x)),
        "virtual_tour_link": virtualTourLink,
      };
}
