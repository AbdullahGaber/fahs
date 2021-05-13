// To parse this JSON data, do
//
//     final changePassewordModel = changePassewordModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChangePassewordModel changePassewordModelFromJson(String str) =>
    ChangePassewordModel.fromJson(json.decode(str));

String changePassewordModelToJson(ChangePassewordModel data) =>
    json.encode(data.toJson());

class ChangePassewordModel {
  ChangePassewordModel({
    @required this.mainCode,
    @required this.code,
    @required this.data,
    @required this.error,
  });

  int mainCode;
  int code;
  Data data;
  List<Error> error;

  factory ChangePassewordModel.fromJson(Map<String, dynamic> json) =>
      ChangePassewordModel(
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
        "data": data.toJson(),
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
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
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
