// To parse this JSON data, do
//
//     final changePhoneModel = changePhoneModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChangePhoneModel changePhoneModelFromJson(String str) =>
    ChangePhoneModel.fromJson(json.decode(str));

String changePhoneModelToJson(ChangePhoneModel data) =>
    json.encode(data.toJson());

class ChangePhoneModel {
  ChangePhoneModel({
    @required this.mainCode,
    @required this.code,
    @required this.data,
    @required this.error,
  });

  int mainCode;
  int code;
  Data data;
  List<Error> error;

  factory ChangePhoneModel.fromJson(Map<String, dynamic> json) =>
      ChangePhoneModel(
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
    @required this.key,
    @required this.value,
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
