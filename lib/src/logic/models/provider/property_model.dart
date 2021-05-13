// To parse this JSON data, do
//
//     final propertyModel = propertyModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PropertyModel propertyModelFromJson(String str) => PropertyModel.fromJson(json.decode(str));

String propertyModelToJson(PropertyModel data) => json.encode(data.toJson());

class PropertyModel {
    PropertyModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    final int mainCode;
    final int code;
    final List<Datum> data;
    final dynamic error;

    factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
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
        @required this.id,
        @required this.name,
        @required this.values,
    });

    final int id;
    final String name;
    final Map<String, String> values;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        values: json["values"] == null ? null : Map.from(json["values"]).map((k, v) => MapEntry<String, String>(k, v)),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "values": values == null ? null : Map.from(values).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}
