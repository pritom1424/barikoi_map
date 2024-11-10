import 'dart:convert';

LocationModel locationModelFromJson(String str) =>
    LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  Place place;
  int status;

  LocationModel({
    required this.place,
    required this.status,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        place: Place.fromJson(json["place"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "place": place.toJson(),
        "status": status,
      };
}

class Place {
  int? id;
  double? distanceWithinMeters;
  String? address;
  String? area;
  String? city;
  String? postCode;
  String? addressBn;
  String? areaBn;
  String? cityBn;
  String? country;
  String? division;
  String? district;
  String? subDistrict;
  dynamic pauroshova;
  dynamic union;
  String? locationType;
  AddressComponents? addressComponents;
  AreaComponents? areaComponents;

  Place({
    this.id,
    this.distanceWithinMeters,
    this.address,
    this.area,
    this.city,
    this.postCode,
    this.addressBn,
    this.areaBn,
    this.cityBn,
    this.country,
    this.division,
    this.district,
    this.subDistrict,
    this.pauroshova,
    this.union,
    this.locationType,
    this.addressComponents,
    this.areaComponents,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json["id"],
        distanceWithinMeters: json["distance_within_meters"]?.toDouble(),
        address: json["address"],
        area: json["area"],
        city: json["city"],
        postCode: json["postCode"],
        addressBn: json["address_bn"],
        areaBn: json["area_bn"],
        cityBn: json["city_bn"],
        country: json["country"],
        division: json["division"],
        district: json["district"],
        subDistrict: json["sub_district"],
        pauroshova: json["pauroshova"],
        union: json["union"],
        locationType: json["location_type"],
        addressComponents: json["address_components"] != null
            ? AddressComponents.fromJson(json["address_components"])
            : null,
        areaComponents: json["area_components"] != null
            ? AreaComponents.fromJson(json["area_components"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "distance_within_meters": distanceWithinMeters,
        "address": address,
        "area": area,
        "city": city,
        "postCode": postCode,
        "address_bn": addressBn,
        "area_bn": areaBn,
        "city_bn": cityBn,
        "country": country,
        "division": division,
        "district": district,
        "sub_district": subDistrict,
        "pauroshova": pauroshova,
        "union": union,
        "location_type": locationType,
        "address_components": addressComponents?.toJson(),
        "area_components": areaComponents?.toJson(),
      };
}

class AddressComponents {
  String? placeName;
  String? house;
  String? road;

  AddressComponents({
    this.placeName,
    this.house,
    this.road,
  });

  factory AddressComponents.fromJson(Map<String, dynamic> json) =>
      AddressComponents(
        placeName: json["place_name"],
        house: json["house"],
        road: json["road"],
      );

  Map<String, dynamic> toJson() => {
        "place_name": placeName,
        "house": house,
        "road": road,
      };
}

class AreaComponents {
  String? area;
  String? subArea;

  AreaComponents({
    this.area,
    this.subArea,
  });

  factory AreaComponents.fromJson(Map<String, dynamic> json) => AreaComponents(
        area: json["area"],
        subArea: json["sub_area"],
      );

  Map<String, dynamic> toJson() => {
        "area": area,
        "sub_area": subArea,
      };
}
