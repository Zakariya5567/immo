// To parse this JSON data, do
//
//     final citiesModel = citiesModelFromJson(jsonString);

import 'dart:convert';

CitiesModel citiesModelFromJson(String str) =>
    CitiesModel.fromJson(json.decode(str));

String citiesModelToJson(CitiesModel data) => json.encode(data.toJson());

class CitiesModel {
  CitiesModel({
    this.predictions,
    this.status,
  });

  List<Prediction>? predictions;
  String? status;

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
        predictions: json["predictions"] == null
            ? []
            : List<Prediction>.from(
                json["predictions"]!.map((x) => Prediction.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "predictions": predictions == null
            ? []
            : List<dynamic>.from(predictions!.map((x) => x.toJson())),
        "status": status,
      };
}

class Prediction {
  Prediction({
    this.description,
    this.placeId,
    this.reference,
  });

  String? description;
  String? placeId;
  String? reference;

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
        description: json["description"],
        placeId: json["place_id"],
        reference: json["reference"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "place_id": placeId,
        "reference": reference,
      };
}
