// To parse this JSON data, do
//
//     final mobileRegisterModel = mobileRegisterModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MobileRegisterModel mobileRegisterModelFromJson(String str) =>
    MobileRegisterModel.fromJson(json.decode(str));

String mobileRegisterModelToJson(MobileRegisterModel data) =>
    json.encode(data.toJson());

class MobileRegisterModel {
  MobileRegisterModel({
    @required this.mainCode,
    @required this.code,
    @required this.data,
    @required this.error,
  });

  final int mainCode;
  final int code;
  final String data;
  final List<Error> error;

  factory MobileRegisterModel.fromJson(Map<String, dynamic> json) =>
      MobileRegisterModel(
        mainCode: json["mainCode"],
        code: json["code"],
        data: json["data"] == null ? null : json["data"],
        error: json["error"] == null
            ? null
            : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mainCode": mainCode,
        "code": code,
        "data": data,
        "error": error,
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
