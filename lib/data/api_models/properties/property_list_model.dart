// To parse this JSON data, do
//
//     final propertiesListModel = propertiesListModelFromJson(jsonString);

import 'dart:convert';
import '/data/api_models/post_an_ad/file_data.Dart';

PropertiesListModel propertiesListModelFromJson(String str) =>
    PropertiesListModel.fromJson(json.decode(str));

String propertiesListModelToJson(PropertiesListModel data) =>
    json.encode(data.toJson());

class PropertiesListModel {
  PropertiesListModel({
    this.data,
    this.links,
    this.meta,
    this.error,
    this.message,
  });

  List<PropertiesData>? data;
  Links? links;
  Meta? meta;
  bool? error;
  String? message;

  factory PropertiesListModel.fromJson(Map<String, dynamic> json) =>
      PropertiesListModel(
        data: json["data"] == null
            ? []
            : List<PropertiesData>.from(
                json["data"]!.map((x) => PropertiesData.fromJson(x))),
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

class PropertiesData {
  PropertiesData({
    this.id,
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
    this.mainImage,
    this.lat,
    this.lng,
    this.streetLat,
    this.streetLng,
    this.documents,
    this.viewsCount,
    this.emailsCount,
    this.callsCount,
    this.imagesCount,
    this.detail,
    this.contact,
    this.editedDate,
    this.published,
    this.isFavourite,
  });

  int? id;
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
  String? streetHouseNumber;
  String? mainImage;
  dynamic lat;
  dynamic lng;
  dynamic streetLat;
  dynamic streetLng;
  Documents? documents;
  int? viewsCount;
  int? emailsCount;
  int? callsCount;
  int? imagesCount;
  Detail? detail;
  Contact? contact;
  String? editedDate;
  int? published;
  bool? isFavourite;

  factory PropertiesData.fromJson(Map<String, dynamic> json) => PropertiesData(
      id: json["id"],
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
      country:
          json["country"] == null ? null : Country.fromJson(json["country"]),
      postcodeCity: json["postcode_city"],
      streetHouseNumber: json["street_house_number"],
      mainImage: json["main_image"],
      lat: json["lat"],
      lng: json["lng"],
      streetLat: json["street_house_number_lat"],
      streetLng: json["street_house_number_lng"],
      documents: json["documents"] == null
          ? null
          : Documents.fromJson(json["documents"]),
      viewsCount: json["views_count"],
      emailsCount: json["emails_count"],
      callsCount: json["calls_count"],
      imagesCount: json["images_count"],
      detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
      contact:
          json["contact"] == null ? null : Contact.fromJson(json["contact"]),
      editedDate: json["edited_date"],
      published: json["published"],
      isFavourite: json["is_favourite"]);

  Map<String, dynamic> toJson() => {
        "id": id,
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
        "main_image": mainImage,
        "lat": lat,
        "lng": lng,
        "street_house_number_lat": streetLat,
        "street_house_number_lng": streetLng,
        "documents": documents?.toJson(),
        "views_count": viewsCount,
        "emails_count": emailsCount,
        "calls_count": callsCount,
        "images_count": imagesCount,
        "detail": detail?.toJson(),
        "contact": contact?.toJson(),
        "edited_date": editedDate,
        "published": published,
        "is_favourite": isFavourite
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
  });

  dynamic shops;
  dynamic location;
  dynamic kindergarten;
  dynamic primarySchool;
  dynamic publicTransport;
  dynamic secondarySchool;
  dynamic motorwayConnection;

  factory Surroundings.fromJson(Map<String, dynamic> json) => Surroundings(
        shops: json["shops"],
        location: json["location"],
        kindergarten: json["kindergarten"],
        primarySchool: json["primary_school"],
        publicTransport: json["public_transport"],
        secondarySchool: json["secondary_school"],
        motorwayConnection: json["motorway_connection"],
      );

  Map<String, dynamic> toJson() => {
        "shops": shops,
        "location": location,
        "kindergarten": kindergarten,
        "primary_school": primarySchool,
        "public_transport": publicTransport,
        "secondary_school": secondarySchool,
        "motorway_connection": motorwayConnection,
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
