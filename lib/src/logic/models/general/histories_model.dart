// To parse this JSON data, do
//
//     final historiesModel = historiesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

HistoriesModel historiesModelFromJson(String str) =>
    HistoriesModel.fromJson(json.decode(str));

String historiesModelToJson(HistoriesModel data) => json.encode(data.toJson());

class HistoriesModel {
  HistoriesModel({
    @required this.mainCode,
    @required this.code,
    @required this.data,
    @required this.error,
  });

  final int mainCode;
  final int code;
  final List<Datum> data;
  final List<Error> error;

  factory HistoriesModel.fromJson(Map<String, dynamic> json) => HistoriesModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"] == null
            ? null
            : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class Datum {
  Datum({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.createdAt,
  });

  final int id;
  final String title;
  final double price;
  final String createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        createdAt: json["created_at"] == null ? null : json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "price": price == null ? null : price,
        "created_at": createdAt == null ? null : createdAt,
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
