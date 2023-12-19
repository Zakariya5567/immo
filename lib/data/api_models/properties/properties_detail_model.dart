// To parse this JSON data, do
//
//     final propertiesDetailModel = propertiesDetailModelFromJson(jsonString);

import 'dart:convert';

import '../post_an_ad/file_data.Dart';

PropertiesDetailModel propertiesDetailModelFromJson(String str) =>
    PropertiesDetailModel.fromJson(json.decode(str));

String propertiesDetailModelToJson(PropertiesDetailModel data) =>
    json.encode(data.toJson());

class PropertiesDetailModel {
  PropertiesDetailModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  Data? data;

  factory PropertiesDetailModel.fromJson(Map<String, dynamic> json) =>
      PropertiesDetailModel(
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
    this.slug,
    this.createdBy,
    this.propertyCategoryId,
    this.propertyCategory,
    this.propertySubCategoryId,
    this.propertySubCategory,
    this.ownershipType,
    this.title,
    this.numberOfHousingUnits,
    this.numberOfRooms,
    this.livingSpace,
    this.plotArea,
    this.floorSpace,
    this.floor,
    this.floortext,
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
    this.country,
    this.postcodeCity,
    this.streetHouseNumber,
    this.streetHouseNumberLat,
    this.streetHouseNumberLng,
    this.documents,
    this.publisher,
    this.viewsCount,
    this.emailsCount,
    this.callsCount,
    this.detail,
    this.contact,
    this.editedDate,
    this.status,
    this.published,
    this.lat,
    this.lng,
    this.isFavourite,
  });

  int? id;
  String? slug;
  int? createdBy;
  int? propertyCategoryId;
  PropertyCategory? propertyCategory;
  int? propertySubCategoryId;
  PropertyCategory? propertySubCategory;
  String? ownershipType;
  String? title;
  int? numberOfHousingUnits;
  dynamic numberOfRooms;
  int? livingSpace;
  int? plotArea;
  int? floorSpace;
  dynamic floor;
  dynamic floortext;
  String? availability;
  DateTime? date;
  String? description;
  String? currency;
  bool? isPrice;
  String? price;
  int? priceOnRequest;
  dynamic sellingPrice;
  String? indicationOfPrice;
  dynamic rentIncludingUtilities;
  dynamic utilities;
  dynamic rentExcludingUtilities;
  dynamic grossReturn;
  Country? country;
  String? postcodeCity;
  dynamic streetHouseNumber;
  dynamic streetHouseNumberLat;
  dynamic streetHouseNumberLng;
  Documents? documents;
  Publisher? publisher;
  int? viewsCount;
  int? emailsCount;
  int? callsCount;
  Detail? detail;
  Contact? contact;
  String? editedDate;
  int? status;
  int? published;
  dynamic lat;
  dynamic lng;
  bool? isFavourite;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        slug: json["slug"],
        createdBy: json["created_by"],
        propertyCategoryId: json["property_category_id"],
        propertyCategory: json["property_category"] == null
            ? null
            : PropertyCategory.fromJson(json["property_category"]),
        propertySubCategoryId: json["property_sub_category_id"],
        propertySubCategory: json["property_sub_category"] == null
            ? null
            : PropertyCategory.fromJson(json["property_sub_category"]),
        ownershipType: json["ownership_type"],
        title: json["title"],
        numberOfHousingUnits: json["number_of_housing_units"],
        numberOfRooms: json["number_of_rooms"],
        livingSpace: json["living_space"],
        plotArea: json["plot_area"],
        floorSpace: json["floor_space"],
        floor: json["floor"],
        floortext: json["floor_text"],
        availability: json["availability"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        description: json["description"],
        currency: json["currency"],
        isPrice: json["is_price"],
        price: json["price"],
        priceOnRequest: json["price_on_request"],
        sellingPrice: json["selling_price"],
        indicationOfPrice: json["indication_of_price"],
        rentIncludingUtilities: json["rent_including_utilities"]?.toDouble(),
        utilities: json["utilities"]?.toDouble(),
        rentExcludingUtilities: json["rent_excluding_utilities"]?.toDouble(),
        grossReturn: json["gross_return"],
        country:
            json["country"] == null ? null : Country.fromJson(json["country"]),
        postcodeCity: json["postcode_city"],
        streetHouseNumber: json["street_house_number"],
        streetHouseNumberLat: json["street_house_number_lat"],
        streetHouseNumberLng: json["street_house_number_lng"],
        documents: json["documents"] == null
            ? null
            : Documents.fromJson(json["documents"]),
        publisher: json["publisher"] == null
            ? null
            : Publisher.fromJson(json["publisher"]),
        viewsCount: json["views_count"],
        emailsCount: json["emails_count"],
        callsCount: json["calls_count"],
        detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
        contact:
            json["contact"] == null ? null : Contact.fromJson(json["contact"]),
        editedDate: json["edited_date"],
        status: json["status"],
        published: json["published"],
        lat: json["lat"],
        lng: json["lng"],
        isFavourite: json["is_favourite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "created_by": createdBy,
        "property_category_id": propertyCategoryId,
        "property_category": propertyCategory?.toJson(),
        "property_sub_category_id": propertySubCategoryId,
        "property_sub_category": propertySubCategory?.toJson(),
        "ownership_type": ownershipType,
        "title": title,
        "number_of_housing_units": numberOfHousingUnits,
        "number_of_rooms": numberOfRooms,
        "living_space": livingSpace,
        "plot_area": plotArea,
        "floor_space": floorSpace,
        "floor": floor,
        "floor_text": floortext,
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
        "country": country?.toJson(),
        "postcode_city": postcodeCity,
        "street_house_number": streetHouseNumber,
        "street_house_number_lat": streetHouseNumberLat,
        "street_house_number_lng": streetHouseNumberLng,
        "documents": documents?.toJson(),
        "publisher": publisher?.toJson(),
        "views_count": viewsCount,
        "emails_count": emailsCount,
        "calls_count": callsCount,
        "detail": detail?.toJson(),
        "contact": contact?.toJson(),
        "edited_date": editedDate,
        "status": status,
        "published": published,
        "lat": lat,
        "lng": lng,
        "is_favourite": isFavourite,
      };
}

class Country {
  Country({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Detail {
  Detail({
    this.id,
    this.propertyId,
    this.dimensions,
    this.interior,
    this.exterior,
    this.equipment,
    this.surroundings,
    this.otherFeatures,
    this.constructionYear,
    this.lastYearRenovated,
  });

  int? id;
  int? propertyId;
  Dimensions? dimensions;
  Interior? interior;
  Exterior? exterior;
  Equipment? equipment;
  Surroundings? surroundings;
  OtherFeatures? otherFeatures;
  int? constructionYear;
  int? lastYearRenovated;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"],
        propertyId: json["property_id"],
        dimensions: json["dimensions"] == null
            ? null
            : Dimensions.fromJson(json["dimensions"]),
        interior: json["interior"] == null
            ? null
            : Interior.fromJson(json["interior"]),
        exterior: json["exterior"] == null
            ? null
            : Exterior.fromJson(json["exterior"]),
        equipment: json["equipment"] == null
            ? null
            : Equipment.fromJson(json["equipment"]),
        surroundings: json["surroundings"] == null
            ? null
            : Surroundings.fromJson(json["surroundings"]),
        otherFeatures: json["other_features"] == null
            ? null
            : OtherFeatures.fromJson(json["other_features"]),
        constructionYear: json["construction_year"],
        lastYearRenovated: json["last_year_renovated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "property_id": propertyId,
        "dimensions": dimensions?.toJson(),
        "interior": interior?.toJson(),
        "exterior": exterior?.toJson(),
        "equipment": equipment?.toJson(),
        "surroundings": surroundings?.toJson(),
        "other_features": otherFeatures?.toJson(),
        "construction_year": constructionYear,
        "last_year_renovated": lastYearRenovated,
      };
}

class Dimensions {
  Dimensions({
    this.cubage,
    this.hallHeight,
    this.roomHeight,
    this.numberOfFloors,
  });

  dynamic cubage;
  dynamic hallHeight;
  dynamic roomHeight;
  dynamic numberOfFloors;

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        cubage: json["cubage"],
        hallHeight: json["hall_height"],
        roomHeight: json["room_height"],
        numberOfFloors: json["number_of_floors"],
      );

  Map<String, dynamic> toJson() => {
        "cubage": cubage,
        "hall_height": hallHeight,
        "room_height": roomHeight,
        "number_of_floors": numberOfFloors,
      };
}

class Equipment {
  Equipment({
    this.dishwasher,
    this.gasSupply,
    this.steamOven,
    this.waterSupply,
    this.liftingPlatform,
    this.ownTumbleDryer,
    this.sewageConnection,
    this.electricitySupply,
    this.minergieCertified,
    this.cableTvConnection,
    this.floorLoadCapacity,
    this.ownWashingMachine,
    this.minergieCertificateNumber,
    this.energyEfficientConstruction,
    this.liftingCapacityOfTheCrane,
    this.loadingCapacityOfTheGoodsLift,
  });

  bool? dishwasher;
  bool? gasSupply;
  bool? steamOven;
  bool? waterSupply;
  bool? liftingPlatform;
  bool? ownTumbleDryer;
  bool? sewageConnection;
  bool? electricitySupply;
  bool? minergieCertified;
  bool? cableTvConnection;
  dynamic floorLoadCapacity;
  bool? ownWashingMachine;
  String? minergieCertificateNumber;
  bool? energyEfficientConstruction;
  dynamic liftingCapacityOfTheCrane;
  dynamic loadingCapacityOfTheGoodsLift;

  factory Equipment.fromJson(Map<String, dynamic> json) => Equipment(
        dishwasher: json["dishwasher"],
        gasSupply: json["gas_supply"],
        steamOven: json["steam_oven"],
        waterSupply: json["water_supply"],
        liftingPlatform: json["lifting_platform"],
        ownTumbleDryer: json["own_tumble_dryer"],
        sewageConnection: json["sewage_connection"],
        electricitySupply: json["electricity_supply"],
        minergieCertified: json["minergie_certified"],
        cableTvConnection: json["cable_tv_connection"],
        floorLoadCapacity: json["floor_load_capacity"],
        ownWashingMachine: json["own_washing_machine"],
        minergieCertificateNumber: json["minergie_certificate_number"],
        energyEfficientConstruction: json["energy_efficient_construction"],
        liftingCapacityOfTheCrane: json["lifting_capacity_of_the_crane"],
        loadingCapacityOfTheGoodsLift:
            json["loading_capacity_of_the_goods_lift"],
      );

  Map<String, dynamic> toJson() => {
        "dishwasher": dishwasher,
        "gas_supply": gasSupply,
        "steam_oven": steamOven,
        "water_supply": waterSupply,
        "lifting_platform": liftingPlatform,
        "own_tumble_dryer": ownTumbleDryer,
        "sewage_connection": sewageConnection,
        "electricity_supply": electricitySupply,
        "minergie_certified": minergieCertified,
        "cable_tv_connection": cableTvConnection,
        "floor_load_capacity": floorLoadCapacity,
        "own_washing_machine": ownWashingMachine,
        "minergie_certificate_number": minergieCertificateNumber,
        "energy_efficient_construction": energyEfficientConstruction,
        "lifting_capacity_of_the_crane": liftingCapacityOfTheCrane,
        "loading_capacity_of_the_goods_lift": loadingCapacityOfTheGoodsLift,
      };
}

class Exterior {
  Exterior({
    this.lift,
    this.garage,
    this.playGround,
    this.loadingRamp,
    this.parkingSpace,
    this.childFriendly,
    this.railwaySiding,
    this.balconyTerracePatio,
    this.minergieCertificateNumber,
  });

  bool? lift;
  bool? garage;
  bool? playGround;
  bool? loadingRamp;
  bool? parkingSpace;
  bool? childFriendly;
  bool? railwaySiding;
  bool? balconyTerracePatio;
  dynamic minergieCertificateNumber;

  factory Exterior.fromJson(Map<String, dynamic> json) => Exterior(
        lift: json["lift"],
        garage: json["garage"],
        playGround: json["play_ground"],
        loadingRamp: json["loading_ramp"],
        parkingSpace: json["parking_space"],
        childFriendly: json["child_friendly"],
        railwaySiding: json["railway_siding"],
        balconyTerracePatio: json["balcony_terrace_patio"],
        minergieCertificateNumber: json["minergie_certificate_number"],
      );

  Map<String, dynamic> toJson() => {
        "lift": lift,
        "garage": garage,
        "play_ground": playGround,
        "loading_ramp": loadingRamp,
        "parking_space": parkingSpace,
        "child_friendly": childFriendly,
        "railway_siding": railwaySiding,
        "balcony_terrace_patio": balconyTerracePatio,
        "minergie_certificate_number": minergieCertificateNumber,
      };
}

class Interior {
  Interior({
    this.view,
    this.attic,
    this.cellar,
    this.toilets,
    this.firePlace,
    this.storageRoom,
    this.petsPermitted,
    this.numberOfBathrooms,
    this.wheelchairAccessible,
  });

  bool? view;
  bool? attic;
  bool? cellar;
  bool? toilets;
  bool? firePlace;
  bool? storageRoom;
  bool? petsPermitted;
  dynamic numberOfBathrooms;
  bool? wheelchairAccessible;

  factory Interior.fromJson(Map<String, dynamic> json) => Interior(
        view: json["view"],
        attic: json["attic"],
        cellar: json["cellar"],
        toilets: json["toilets"],
        firePlace: json["fire_place"],
        storageRoom: json["storage_room"],
        petsPermitted: json["pets_permitted"],
        numberOfBathrooms: json["number_of_bathrooms"],
        wheelchairAccessible: json["wheelchair_accessible"],
      );

  Map<String, dynamic> toJson() => {
        "view": view,
        "attic": attic,
        "cellar": cellar,
        "toilets": toilets,
        "fire_place": firePlace,
        "storage_room": storageRoom,
        "pets_permitted": petsPermitted,
        "number_of_bathrooms": numberOfBathrooms,
        "wheelchair_accessible": wheelchairAccessible,
      };
}

class OtherFeatures {
  OtherFeatures({
    this.covered,
    this.building,
    this.developed,
    this.gardenHut,
    this.leaseHold,
    this.buildingType,
    this.swimmingPool,
    this.midTerraceHouse,
    this.houseOrFlatShare,
    this.cornerHouseOrEndOfTerraceHouse,
  });

  bool? covered;
  String? building;
  bool? developed;
  bool? gardenHut;
  bool? leaseHold;
  String? buildingType;
  bool? swimmingPool;
  bool? midTerraceHouse;
  bool? houseOrFlatShare;
  bool? cornerHouseOrEndOfTerraceHouse;

  factory OtherFeatures.fromJson(Map<String, dynamic> json) => OtherFeatures(
        covered: json["covered"],
        building: json["building"],
        developed: json["developed"],
        gardenHut: json["garden_hut"],
        leaseHold: json["lease_hold"],
        buildingType: json["building_type"],
        swimmingPool: json["swimming_pool"],
        midTerraceHouse: json["mid_terrace_house"],
        houseOrFlatShare: json["house_or_flat_share"],
        cornerHouseOrEndOfTerraceHouse:
            json["corner_house_or_end_of_terrace_house"],
      );

  Map<String, dynamic> toJson() => {
        "covered": covered,
        "building": building,
        "developed": developed,
        "garden_hut": gardenHut,
        "lease_hold": leaseHold,
        "building_type": buildingType,
        "swimming_pool": swimmingPool,
        "mid_terrace_house": midTerraceHouse,
        "house_or_flat_share": houseOrFlatShare,
        "corner_house_or_end_of_terrace_house": cornerHouseOrEndOfTerraceHouse,
      };
}

class Surroundings {
  Surroundings({
    this.shops,
    this.location,
    this.kindergarten,
    this.primarySchool,
    this.publicTransport,
    this.secondarySchool,
    this.motorwayConnection,
    this.railwaySiding,
  });

  dynamic shops;
  dynamic location;
  dynamic kindergarten;
  dynamic primarySchool;
  dynamic publicTransport;
  dynamic secondarySchool;
  dynamic motorwayConnection;
  bool? railwaySiding;

  factory Surroundings.fromJson(Map<String, dynamic> json) => Surroundings(
        shops: json["shops"],
        location: json["location"],
        kindergarten: json["kindergarten"],
        primarySchool: json["primary_school"],
        publicTransport: json["public_transport"],
        secondarySchool: json["secondary_school"],
        motorwayConnection: json["motorway_connection"],
        railwaySiding: json["railway_siding"],
      );

  Map<String, dynamic> toJson() => {
        "shops": shops,
        "location": location,
        "kindergarten": kindergarten,
        "primary_school": primarySchool,
        "public_transport": publicTransport,
        "secondary_school": secondarySchool,
        "motorway_connection": motorwayConnection,
        "railway_siding": railwaySiding,
      };
}

class Documents {
  Documents({
    this.youtubeVideos,
    this.virtualTourLink,
    this.images,
    this.pdfFiles,
  });

  List<dynamic>? youtubeVideos;
  String? virtualTourLink;
  List<FileData>? images;
  List<FileData>? pdfFiles;

  factory Documents.fromJson(Map<String, dynamic> json) => Documents(
        youtubeVideos: json["youtube_videos"] == null
            ? []
            : List<dynamic>.from(json["youtube_videos"]!.map((x) => x)),
        virtualTourLink: json["virtual_tour_link"],
        images: json["images"] == null
            ? []
            : List<FileData>.from(
                json["images"]!.map((x) => FileData.fromJson(x))),
        pdfFiles: json["pdf_files"] == null
            ? []
            : List<FileData>.from(
                json["pdf_files"]!.map((x) => FileData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "youtube_videos": youtubeVideos == null
            ? []
            : List<dynamic>.from(youtubeVideos!.map((x) => x)),
        "virtual_tour_link": virtualTourLink,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "pdf_files": pdfFiles == null
            ? []
            : List<dynamic>.from(pdfFiles!.map((x) => x.toJson())),
      };
}

class Contact {
  Contact({
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

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
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

class PropertyCategory {
  PropertyCategory({
    this.id,
    this.title,
  });

  int? id;
  String? title;

  factory PropertyCategory.fromJson(Map<String, dynamic> json) =>
      PropertyCategory(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

class Publisher {
  int? id;
  String? username;
  String? email;
  String? phoneNumber;
  String? address;
  String? location;
  String? lat;
  String? lng;
  String? website;
  int? isCompany;
  dynamic companyName;
  int? status;
  String? avatar;
  String? device;
  String? fcmToken;

  Publisher({
    this.id,
    this.username,
    this.email,
    this.phoneNumber,
    this.address,
    this.location,
    this.lat,
    this.lng,
    this.website,
    this.isCompany,
    this.companyName,
    this.status,
    this.avatar,
    this.device,
    this.fcmToken,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) => Publisher(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        location: json["location"],
        lat: json["lat"],
        lng: json["lng"],
        website: json["website"],
        isCompany: json["is_company"],
        companyName: json["company_name"],
        status: json["status"],
        avatar: json["avatar"],
        device: json["device"],
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "location": location,
        "lat": lat,
        "lng": lng,
        "website": website,
        "is_company": isCompany,
        "company_name": companyName,
        "status": status,
        "avatar": avatar,
        "device": device,
        "fcm_token": fcmToken,
      };
}
