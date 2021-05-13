// To parse this JSON data, do
//
//     final citiesModel = citiesModelFromJson(jsonString);

import 'dart:convert';

CitiesModel citiesModelFromJson(String str) => CitiesModel.fromJson(json.decode(str));

String citiesModelToJson(CitiesModel data) => json.encode(data.toJson());

class CitiesModel {
    CitiesModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    dynamic error;

    factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
    };
}

class Datum {
    Datum({
        this.id,
        this.name,
        this.regionId,
        this.regionName,
    });

    int id;
    String name;
    int regionId;
    String regionName;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        regionId: json["region_id"] == null ? null : json["region_id"],
        regionName: json["region_name"] == null ? null : json["region_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "region_id": regionId == null ? null : regionId,
        "region_name": regionName == null ? null : regionName,
    };
}
