// To parse this JSON data, do
//
//     final getAlertModel = getAlertModelFromJson(jsonString);

import 'dart:convert';

GetAlertModel getAlertModelFromJson(String str) =>
    GetAlertModel.fromJson(json.decode(str));

String getAlertModelToJson(GetAlertModel data) => json.encode(data.toJson());

class GetAlertModel {
  GetAlertModel({
    this.data,
    this.links,
    this.meta,
    this.error,
    this.message,
  });

  List<Datum>? data;
  Links? links;
  Meta? meta;
  bool? error;
  String? message;

  factory GetAlertModel.fromJson(Map<String, dynamic> json) => GetAlertModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links?.toJson(),
        "meta": meta?.toJson(),
        "error": error,
        "message": message,
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.email,
    this.address,
    this.coordinates,
    this.currency,
    this.priceRange,
    this.bathRooms,
    this.bedRooms,
    this.bedRoomsRange,
    this.livingSpaceRange,
    this.ownershipType,
    this.propertyCategoryId,
    this.subCategoryIds,
    this.adsWith,
    this.ageOfAd,
    this.floor,
    this.availabilityFrom,
    this.availabilityTo,
    this.availabilityIndication,
    this.sortByFilter,
    this.validTill,
    this.characteristics,
  });

  int? id;
  String? name;
  String? email;
  Address? address;
  List<Coordinate>? coordinates;
  String? currency;
  CeRange? priceRange;
  dynamic bathRooms;
  int? bedRooms;
  dynamic bedRoomsRange;
  CeRange? livingSpaceRange;
  String? ownershipType;
  dynamic propertyCategoryId;
  dynamic subCategoryIds;
  Map<String, bool>? adsWith;
  String? ageOfAd;
  // Map<String, bool>? ageOfAd;
  Map<String, bool>? floor;
  String? availabilityFrom;
  String? availabilityTo;
  dynamic availabilityIndication;
  String? sortByFilter;
  String? validTill;
  Map<String, dynamic>? characteristics;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        coordinates: json["coordinates"] == null
            ? []
            : List<Coordinate>.from(
                json["coordinates"]!.map((x) => Coordinate.fromJson(x))),
        currency: json["currency"],
        priceRange: json["price_range"] == null
            ? null
            : CeRange.fromJson(json["price_range"]),
        bathRooms: json["bath_rooms"],
        bedRooms: json["bed_rooms"],
        bedRoomsRange: json["bed_rooms_range"],
        livingSpaceRange: json["living_space_range"] == null
            ? null
            : CeRange.fromJson(json["living_space_range"]),
        ownershipType: json["ownership_type"],
        propertyCategoryId: json["property_category_id"],
        subCategoryIds: json["sub_category_ids"],
        adsWith: Map.from(json["ads_with"]!)
            .map((k, v) => MapEntry<String, bool>(k, v)),
        ageOfAd: json["age_of_ad"],
        // ageOfAd: Map.from(json["age_of_ad"]!)
        //     .map((k, v) => MapEntry<String, bool>(k, v)),
        floor: Map.from(json["floor"]!)
            .map((k, v) => MapEntry<String, bool>(k, v)),
        availabilityFrom: json["availability_from"],
        availabilityTo: json["availability_to"],
        availabilityIndication: json["availability_indication"],
        sortByFilter: json["sort_by_filter"],
        validTill: json["valid_till"],
        characteristics: Map.from(json["characteristics"]!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "address": address?.toJson(),
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x.toJson())),
        "currency": currency,
        "price_range": priceRange?.toJson(),
        "bath_rooms": bathRooms,
        "bed_rooms": bedRooms,
        "bed_rooms_range": bedRoomsRange,
        "living_space_range": livingSpaceRange?.toJson(),
        "ownership_type": ownershipType,
        "property_category_id": propertyCategoryId,
        "sub_category_ids": subCategoryIds,
        "ads_with":
            Map.from(adsWith!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "age_of_ad": ageOfAd,
        // Map.from(ageOfAd!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "floor":
            Map.from(floor!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "availability_from": availabilityFrom,
        "availability_to": availabilityTo,
        "availability_indication": availabilityIndication,
        "sort_by_filter": sortByFilter,
        "valid_till": validTill,
        "characteristics": Map.from(characteristics!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class Address {
  Address({
    this.lat,
    this.lng,
    this.postcodeCity,
  });

  dynamic lat;
  dynamic lng;
  String? postcodeCity;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        lat: json["lat"],
        lng: json["lng"],
        postcodeCity: json["postcode_city"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
        "postcode_city": postcodeCity,
      };
}

class CeRange {
  CeRange({
    this.max,
    this.min,
  });

  String? max;
  String? min;

  factory CeRange.fromJson(Map<String, dynamic> json) => CeRange(
        max: json["max"],
        min: json["min"],
      );

  Map<String, dynamic> toJson() => {
        "max": max,
        "min": min,
      };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

class Coordinate {
  Coordinate({
    this.lat,
    this.lng,
  });

  String? lat;
  String? lng;

  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
