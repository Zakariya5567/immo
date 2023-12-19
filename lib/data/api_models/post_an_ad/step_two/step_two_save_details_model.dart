// To parse this JSON data, do
//
//     final saveDetailsModel = saveDetailsModelFromJson(jsonString);

import 'dart:convert';

SaveDetailsModel saveDetailsModelFromJson(String str) =>
    SaveDetailsModel.fromJson(json.decode(str));

String saveDetailsModelToJson(SaveDetailsModel data) =>
    json.encode(data.toJson());

class SaveDetailsModel {
  SaveDetailsModel({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  Data? data;

  factory SaveDetailsModel.fromJson(Map<String, dynamic> json) =>
      SaveDetailsModel(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    this.roomHeight,
    this.hallHeight,
    this.cubage,
    this.numberOfFloors,
  });

  double? roomHeight;
  double? hallHeight;
  double? cubage;
  int? numberOfFloors;

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        roomHeight: json["room_height"]?.toDouble(),
        hallHeight: json["hall_height"]?.toDouble(),
        cubage: json["cubage"]?.toDouble(),
        numberOfFloors: json["number_of_floors"],
      );

  Map<String, dynamic> toJson() => {
        "room_height": roomHeight,
        "hall_height": hallHeight,
        "cubage": cubage,
        "number_of_floors": numberOfFloors,
      };
}

class Equipment {
  Equipment({
    this.minergieCertificateNumber,
    this.energyEfficientConstruction,
    this.minergieCertified,
    this.sewageConnection,
    this.electricitySupply,
    this.gasSupply,
    this.steamOven,
    this.dishwasher,
    this.ownTumbleDryer,
    this.ownWashingMachine,
    this.cableTvConnection,
    this.waterSupply,
    this.liftingCapacityOfTheCrane,
    this.loadingCapacityOfTheGoodsLift,
    this.floorLoadCapacity,
    this.liftingPlatform,
  });

  String? minergieCertificateNumber;
  bool? energyEfficientConstruction;
  bool? minergieCertified;
  bool? sewageConnection;
  bool? electricitySupply;
  bool? gasSupply;
  bool? steamOven;
  bool? dishwasher;
  bool? ownTumbleDryer;
  bool? ownWashingMachine;
  bool? cableTvConnection;
  bool? waterSupply;
  double? liftingCapacityOfTheCrane;
  double? loadingCapacityOfTheGoodsLift;
  double? floorLoadCapacity;
  bool? liftingPlatform;

  factory Equipment.fromJson(Map<String, dynamic> json) => Equipment(
        minergieCertificateNumber: json["minergie_certificate_number"],
        energyEfficientConstruction: json["energy_efficient_construction"],
        minergieCertified: json["minergie_certified"],
        sewageConnection: json["sewage_connection"],
        electricitySupply: json["electricity_supply"],
        gasSupply: json["gas_supply"],
        steamOven: json["steam_oven"],
        dishwasher: json["dishwasher"],
        ownTumbleDryer: json["own_tumble_dryer"],
        ownWashingMachine: json["own_washing_machine"],
        cableTvConnection: json["cable_tv_connection"],
        waterSupply: json["water_supply"],
        liftingCapacityOfTheCrane:
            json["lifting_capacity_of_the_crane"]?.toDouble(),
        loadingCapacityOfTheGoodsLift:
            json["loading_capacity_of_the_goods_lift"]?.toDouble(),
        floorLoadCapacity: json["floor_load_capacity"]?.toDouble(),
        liftingPlatform: json["lifting_platform"],
      );

  Map<String, dynamic> toJson() => {
        "minergie_certificate_number": minergieCertificateNumber,
        "energy_efficient_construction": energyEfficientConstruction,
        "minergie_certified": minergieCertified,
        "sewage_connection": sewageConnection,
        "electricity_supply": electricitySupply,
        "gas_supply": gasSupply,
        "steam_oven": steamOven,
        "dishwasher": dishwasher,
        "own_tumble_dryer": ownTumbleDryer,
        "own_washing_machine": ownWashingMachine,
        "cable_tv_connection": cableTvConnection,
        "water_supply": waterSupply,
        "lifting_capacity_of_the_crane": liftingCapacityOfTheCrane,
        "loading_capacity_of_the_goods_lift": loadingCapacityOfTheGoodsLift,
        "floor_load_capacity": floorLoadCapacity,
        "lifting_platform": liftingPlatform,
      };
}

class Exterior {
  Exterior({
    this.lift,
    this.balconyTerracePatio,
    this.childFriendly,
    this.playGround,
    this.parkingSpace,
    this.garage,
    this.loadingRamp,
  });

  bool? lift;
  bool? balconyTerracePatio;
  bool? childFriendly;
  bool? playGround;
  bool? parkingSpace;
  bool? garage;
  bool? loadingRamp;

  factory Exterior.fromJson(Map<String, dynamic> json) => Exterior(
        lift: json["lift"],
        balconyTerracePatio: json["balcony_terrace_patio"],
        childFriendly: json["child_friendly"],
        playGround: json["play_ground"],
        parkingSpace: json["parking_space"],
        garage: json["garage"],
        loadingRamp: json["loading_ramp"],
      );

  Map<String, dynamic> toJson() => {
        "lift": lift,
        "balcony_terrace_patio": balconyTerracePatio,
        "child_friendly": childFriendly,
        "play_ground": playGround,
        "parking_space": parkingSpace,
        "garage": garage,
        "loading_ramp": loadingRamp,
      };
}

class Interior {
  Interior({
    this.wheelchairAccessible,
    this.view,
    this.petsPermitted,
    this.attic,
    this.cellar,
    this.storageRoom,
    this.firePlace,
    this.toilets,
    this.numberOfBathrooms,
  });

  bool? wheelchairAccessible;
  bool? view;
  bool? petsPermitted;
  bool? attic;
  bool? cellar;
  bool? storageRoom;
  bool? firePlace;
  bool? toilets;
  int? numberOfBathrooms;

  factory Interior.fromJson(Map<String, dynamic> json) => Interior(
        wheelchairAccessible: json["wheelchair_accessible"],
        view: json["view"],
        petsPermitted: json["pets_permitted"],
        attic: json["attic"],
        cellar: json["cellar"],
        storageRoom: json["storage_room"],
        firePlace: json["fire_place"],
        toilets: json["toilets"],
        numberOfBathrooms: json["number_of_bathrooms"],
      );

  Map<String, dynamic> toJson() => {
        "wheelchair_accessible": wheelchairAccessible,
        "view": view,
        "pets_permitted": petsPermitted,
        "attic": attic,
        "cellar": cellar,
        "storage_room": storageRoom,
        "fire_place": firePlace,
        "toilets": toilets,
        "number_of_bathrooms": numberOfBathrooms,
      };
}

class OtherFeatures {
  OtherFeatures({
    this.building,
    this.houseOrFlatShare,
    this.leaseHold,
    this.swimmingPool,
    this.cornerHouseOrEndOfTerraceHouse,
    this.midTerraceHouse,
    this.covered,
    this.gardenHut,
    this.developed,
  });

  String? building;
  bool? houseOrFlatShare;
  bool? leaseHold;
  bool? swimmingPool;
  bool? cornerHouseOrEndOfTerraceHouse;
  bool? midTerraceHouse;
  bool? covered;
  bool? gardenHut;
  bool? developed;

  factory OtherFeatures.fromJson(Map<String, dynamic> json) => OtherFeatures(
        building: json["building"],
        houseOrFlatShare: json["house_or_flat_share"],
        leaseHold: json["lease_hold"],
        swimmingPool: json["swimming_pool"],
        cornerHouseOrEndOfTerraceHouse:
            json["corner_house_or_end_of_terrace_house"],
        midTerraceHouse: json["mid_terrace_house"],
        covered: json["covered"],
        gardenHut: json["garden_hut"],
        developed: json["developed"],
      );

  Map<String, dynamic> toJson() => {
        "building": building,
        "house_or_flat_share": houseOrFlatShare,
        "lease_hold": leaseHold,
        "swimming_pool": swimmingPool,
        "corner_house_or_end_of_terrace_house": cornerHouseOrEndOfTerraceHouse,
        "mid_terrace_house": midTerraceHouse,
        "covered": covered,
        "garden_hut": gardenHut,
        "developed": developed,
      };
}

class Surroundings {
  Surroundings({
    this.kindergarten,
    this.primarySchool,
    this.secondarySchool,
    this.railwaySiding,
    this.publicTransport,
    this.motorwayConnection,
    this.location,
  });

  double? kindergarten;
  double? primarySchool;
  double? secondarySchool;
  bool? railwaySiding;
  double? publicTransport;
  double? motorwayConnection;
  String? location;

  factory Surroundings.fromJson(Map<String, dynamic> json) => Surroundings(
        kindergarten: json["kindergarten"]?.toDouble(),
        primarySchool: json["primary_school"]?.toDouble(),
        secondarySchool: json["secondary_school"]?.toDouble(),
        railwaySiding: json["railway_siding"],
        publicTransport: json["public_transport"]?.toDouble(),
        motorwayConnection: json["motorway_connection"]?.toDouble(),
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "kindergarten": kindergarten,
        "primary_school": primarySchool,
        "secondary_school": secondarySchool,
        "railway_siding": railwaySiding,
        "public_transport": publicTransport,
        "motorway_connection": motorwayConnection,
        "location": location,
      };
}
