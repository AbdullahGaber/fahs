// To parse this JSON data, do
//
//     final regionsModel = regionsModelFromJson(jsonString);

import 'dart:convert';

RegionsModel regionsModelFromJson(String str) => RegionsModel.fromJson(json.decode(str));

String regionsModelToJson(RegionsModel data) => json.encode(data.toJson());

class RegionsModel {
    RegionsModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    dynamic error;

    factory RegionsModel.fromJson(Map<String, dynamic> json) => RegionsModel(
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
    });

    int id;
    String name;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
    };
}
