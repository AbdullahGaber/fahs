// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    @required this.mainCode,
    @required this.code,
    @required this.data,
    @required this.error,
  });

  final int mainCode;
  final int code;
  final List<Datum> data;
  final List<Error> error;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        mainCode: json["mainCode"],
        code: json["code"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"] == null
            ? null
            : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mainCode": mainCode,
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class Datum {
  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        phoneNumber: json["phone_number"],
        name: json["name"],
        type: json["type"],
        blocked: json["blocked"],
        image: json["image"],
        email: json["email"],
        apiToken: json["api_token"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        commercialRecord: json["commercial_record"],
        commercialImage: json["commercial_image"],
        active: json["active"],
        regionId: json["region_id"],
        regionName: json["region_name"],
        cityId: json["city_id"],
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone_number": phoneNumber,
        "name": name,
        "type": type,
        "blocked": blocked,
        "image": image,
        "email": email,
        "api_token": apiToken,
        "latitude": latitude,
        "longitude": longitude,
        "commercial_record": commercialRecord,
        "commercial_image": commercialImage,
        "active": active,
        "region_id": regionId,
        "region_name": regionName,
        "city_id": cityId,
        "city_name": cityName,
      };
}

class Error {
  Error({
    @required this.key,
    @required this.value,
  });

  final String key;
  final String value;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}
