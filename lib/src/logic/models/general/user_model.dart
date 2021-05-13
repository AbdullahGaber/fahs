// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    Data data;
    dynamic error;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"],
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
        this.id,
        this.phoneNumber,
        this.name,
        this.type,
        this.blocked,
        this.image,
        this.email,
        this.apiToken,
        this.latitude,
        this.longitude,
        this.commercialRecord,
        this.commercialImage,
        this.active,
        this.regionId,
        this.regionName,
        this.cityId,
        this.cityName,
    });

    int id;
    String phoneNumber;
    String name;
    String type;
    bool blocked;
    String image;
    String email;
    String apiToken;
    double latitude;
    double longitude;
    String commercialRecord;
    String commercialImage;
    int active;
    int regionId;
    String regionName;
    int cityId;
    String cityName;

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
        longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
        commercialRecord: json["commercial_record"] == null ? null : json["commercial_record"],
        commercialImage: json["commercial_image"] == null ? null : json["commercial_image"],
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
