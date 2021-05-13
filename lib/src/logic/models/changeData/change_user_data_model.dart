// To parse this JSON data, do
//
//     final changeUserDataModel = changeUserDataModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChangeUserDataModel changeUserDataModelFromJson(String str) =>
    ChangeUserDataModel.fromJson(json.decode(str));

String changeUserDataModelToJson(ChangeUserDataModel data) =>
    json.encode(data.toJson());

class ChangeUserDataModel {
  ChangeUserDataModel({
    @required this.mainCode,
    @required this.code,
    @required this.data,
    @required this.error,
  });

  final int mainCode;
  final int code;
  final Data data;
  final List<Error> error;

  factory ChangeUserDataModel.fromJson(Map<String, dynamic> json) =>
      ChangeUserDataModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"] == null
            ? null
            : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
        "error": error,
      };
}

class Data {
  Data({
    @required this.id,
    @required this.phoneNumber,
    @required this.name,
    @required this.type,
    @required this.blocked,
    @required this.image,
    @required this.email,
    @required this.apiToken,
    @required this.latitude,
    @required this.longitude,
    @required this.commercialRecord,
    @required this.commercialImage,
    @required this.active,
    @required this.regionId,
    @required this.regionName,
    @required this.cityId,
    @required this.cityName,
  });

  final int id;
  final String phoneNumber;
  final String name;
  final String type;
  final bool blocked;
  final String image;
  final String email;
  final String apiToken;
  final double latitude;
  final double longitude;
  final String commercialRecord;
  final String commercialImage;
  final int active;
  final int regionId;
  final String regionName;
  final int cityId;
  final String cityName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        blocked: json["blocked"] == null ? null : json["blocked"],
        image: json["image"] == null ? null : json["image"],
        email: json["email"] == null ? null : json["email"],
        apiToken: json["api_token"] == null ? null : json["api_token"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        commercialRecord: json["commercial_record"] == null
            ? null
            : json["commercial_record"],
        commercialImage:
            json["commercial_image"] == null ? null : json["commercial_image"],
        active: json["active"] == null ? null : json["active"],
        regionId: json["region_id"] == null ? null : json["region_id"],
        regionName: json["region_name"] == null ? null : json["region_name"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        cityName: json["city_name"] == null ? null : json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "blocked": blocked == null ? null : blocked,
        "image": image == null ? null : image,
        "email": email == null ? null : email,
        "api_token": apiToken == null ? null : apiToken,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "commercial_record": commercialRecord == null ? null : commercialRecord,
        "commercial_image": commercialImage == null ? null : commercialImage,
        "active": active == null ? null : active,
        "region_id": regionId == null ? null : regionId,
        "region_name": regionName == null ? null : regionName,
        "city_id": cityId == null ? null : cityId,
        "city_name": cityName == null ? null : cityName,
      };
}

class Error {
  Error({
    this.key,
    this.value,
  });

  String key;
  String value;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "value": value == null ? null : value,
      };
}
