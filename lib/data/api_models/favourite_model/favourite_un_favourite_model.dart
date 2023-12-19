// To parse this JSON data, do
//
//     final favouriteUnFavouriteModel = favouriteUnFavouriteModelFromJson(jsonString);

import 'dart:convert';

FavouriteUnFavouriteModel favouriteUnFavouriteModelFromJson(String str) =>
    FavouriteUnFavouriteModel.fromJson(json.decode(str));

String favouriteUnFavouriteModelToJson(FavouriteUnFavouriteModel data) =>
    json.encode(data.toJson());

class FavouriteUnFavouriteModel {
  FavouriteUnFavouriteModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  dynamic data;

  factory FavouriteUnFavouriteModel.fromJson(Map<String, dynamic> json) =>
      FavouriteUnFavouriteModel(
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
