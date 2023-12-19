class DrawnMapModel {
  double? latitude;
  double? longitude;

  DrawnMapModel({this.latitude, this.longitude});

  Map<String, dynamic> toJson({required newLat, required newLng}) => {
        "lat": newLat,
        "lng": newLng,
      };
}
