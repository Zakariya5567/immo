// To parse this JSON data, do
//
//     final savePropertiesModel = savePropertiesModelFromJson(jsonString);

import 'dart:convert';

SavePropertiesModel savePropertiesModelFromJson(String str) =>
    SavePropertiesModel.fromJson(json.decode(str));

String savePropertiesModelToJson(SavePropertiesModel data) =>
    json.encode(data.toJson());

class SavePropertiesModel {
  SavePropertiesModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  Data? data;

  factory SavePropertiesModel.fromJson(Map<String, dynamic> json) =>
      SavePropertiesModel(
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
    this.createdBy,
    this.propertyCategoryId,
    this.propertySubCategoryId,
    this.ownershipType,
    this.title,
    this.numberOfHousingUnits,
    this.numberOfRooms,
    this.livingSpace,
    this.plotArea,
    this.floorSpace,
    this.floor,
    this.availability,
    this.date,
    this.description,
    this.currency,
    this.isPrice,
    this.price,
    this.priceOnRequest,
    this.sellingPrice,
    this.indicationOfPrice,
    this.rentIncludingUtilities,
    this.utilities,
    this.rentExcludingUtilities,
    this.grossReturn,
    this.postcodeCity,
    this.streetHouseNumber,
    this.lat,
    this.lng,
    this.streetLat,
    this.streetLng,
    this.documents,
    this.viewsCount,
    this.emailsCount,
    this.callsCount,
    this.editedDate,
    this.status,
    this.published,
  });

  int? id;
  int? createdBy;
  String? propertyCategoryId;
  String? propertySubCategoryId;
  String? ownershipType;
  String? title;
  dynamic numberOfHousingUnits;
  dynamic numberOfRooms;
  dynamic livingSpace;
  dynamic plotArea;
  dynamic floorSpace;
  String? floor;
  String? availability;
  DateTime? date;
  String? description;
  String? currency;
  bool? isPrice;
  String? price;
  String? priceOnRequest;
  dynamic sellingPrice;
  String? indicationOfPrice;
  dynamic rentIncludingUtilities;
  dynamic utilities;
  dynamic rentExcludingUtilities;
  dynamic grossReturn;
  String? postcodeCity;
  dynamic streetHouseNumber;
  dynamic lat;
  dynamic lng;
  dynamic streetLat;
  dynamic streetLng;
  DocumentsData? documents;
  dynamic viewsCount;
  dynamic emailsCount;
  dynamic callsCount;
  String? editedDate;
  dynamic status;
  dynamic published;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        createdBy: json["created_by"],
        propertyCategoryId: json["property_category_id"],
        propertySubCategoryId: json["property_sub_category_id"],
        ownershipType: json["ownership_type"],
        title: json["title"],
        numberOfHousingUnits: json["number_of_housing_units"],
        numberOfRooms: json["number_of_rooms"],
        livingSpace: json["living_space"],
        plotArea: json["plot_area"],
        floorSpace: json["floor_space"],
        floor: json["floor"],
        availability: json["availability"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        description: json["description"],
        currency: json["currency"],
        isPrice: json["is_price"],
        price: json["price"],
        priceOnRequest: json["price_on_request"],
        sellingPrice: json["selling_price"],
        indicationOfPrice: json["indication_of_price"],
        rentIncludingUtilities: json["rent_including_utilities"],
        utilities: json["utilities"],
        rentExcludingUtilities: json["rent_excluding_utilities"],
        grossReturn: json["gross_return"],
        postcodeCity: json["postcode_city"],
        streetHouseNumber: json["street_house_number"],
        lat: json["lat"],
        lng: json["lng"],
        streetLat: json["street_house_number_lat"],
        streetLng: json["street_house_number_lng"],
        documents: json["documents"] == null
            ? null
            : DocumentsData.fromJson(json["documents"]),
        viewsCount: json["views_count"],
        emailsCount: json["emails_count"],
        callsCount: json["calls_count"],
        editedDate: json["edited_date"],
        status: json["status"],
        published: json["published"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_by": createdBy,
        "property_category_id": propertyCategoryId,
        "property_sub_category_id": propertySubCategoryId,
        "ownership_type": ownershipType,
        "title": title,
        "number_of_housing_units": numberOfHousingUnits,
        "number_of_rooms": numberOfRooms,
        "living_space": livingSpace,
        "plot_area": plotArea,
        "floor_space": floorSpace,
        "floor": floor,
        "availability": availability,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "description": description,
        "currency": currency,
        "is_price": isPrice,
        "price": price,
        "price_on_request": priceOnRequest,
        "selling_price": sellingPrice,
        "indication_of_price": indicationOfPrice,
        "rent_including_utilities": rentIncludingUtilities,
        "utilities": utilities,
        "rent_excluding_utilities": rentExcludingUtilities,
        "gross_return": grossReturn,
        "postcode_city": postcodeCity,
        "street_house_number": streetHouseNumber,
        "lat": lat,
        "lng": lng,
        "street_house_number_lat": streetLat,
        "street_house_number_lng": streetLng,
        "documents": documents?.toJson(),
        "views_count": viewsCount,
        "emails_count": emailsCount,
        "calls_count": callsCount,
        "edited_date": editedDate,
        "status": status,
        "published": published,
      };
}

class DocumentsData {
  DocumentsData({
    this.youtubeVideos,
    this.virtualTourLink,
  });

  List<dynamic>? youtubeVideos;
  dynamic virtualTourLink;

  factory DocumentsData.fromJson(Map<String, dynamic> json) => DocumentsData(
        youtubeVideos: json["youtube_videos"] == null
            ? []
            : List<dynamic>.from(json["youtube_videos"]!.map((x) => x)),
        virtualTourLink: json["virtual_tour_link"],
      );

  Map<String, dynamic> toJson() => {
        "youtube_videos": youtubeVideos == null
            ? []
            : List<dynamic>.from(youtubeVideos!.map((x) => x)),
        "virtual_tour_link": virtualTourLink,
      };
}
