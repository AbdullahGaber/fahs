// To parse this JSON data, do
//
//     final logoutModel = logoutModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LogoutModel logoutModelFromJson(String str) =>
    LogoutModel.fromJson(json.decode(str));

String logoutModelToJson(LogoutModel data) => json.encode(data.toJson());

class LogoutModel {
  LogoutModel({
    @required this.mainCode,
    @required this.code,
    @required this.data,
    @required this.error,
  });

  final int mainCode;
  final int code;
  final List<dynamic> data;
  final List<Error> error;

  factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
        mainCode: json["mainCode"],
        code: json["code"],
        data: json["data"] == null
            ? null
            : List<dynamic>.from(json["data"].map((x) => x)),
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
