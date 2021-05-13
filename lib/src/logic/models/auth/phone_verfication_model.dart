// To parse this JSON data, do
//
//     final phoneVerficationModel = phoneVerficationModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PhoneVerficationModel phoneVerficationModelFromJson(String str) =>
    PhoneVerficationModel.fromJson(json.decode(str));

String phoneVerficationModelToJson(PhoneVerficationModel data) =>
    json.encode(data.toJson());

class PhoneVerficationModel {
  PhoneVerficationModel({
    @required this.mainCode,
    @required this.code,
    @required this.data,
    @required this.error,
  });

  final int mainCode;
  final int code;
  final Data data;
  final List<Error> error;

  factory PhoneVerficationModel.fromJson(Map<String, dynamic> json) =>
      PhoneVerficationModel(
        mainCode: json["mainCode"],
        code: json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"] == null
            ? null
            : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mainCode": mainCode,
        "code": code,
        "data": data,
        "error": List<dynamic>.from(error.map((x) => x.toJson())),
      };
}
class Data {
    Data({
        this.key,
        this.value,
    });

    String key;
    String value;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
    );

    Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "value": value == null ? null : value,
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
