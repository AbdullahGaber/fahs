// To parse this JSON data, do
//
//     final completeOrderModel = completeOrderModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CompleteOrderModel completeOrderModelFromJson(String str) =>
    CompleteOrderModel.fromJson(json.decode(str));

String completeOrderModelToJson(CompleteOrderModel data) =>
    json.encode(data.toJson());

class CompleteOrderModel {
  CompleteOrderModel({
    @required this.mainCode,
    @required this.code,
    @required this.data,
    @required this.error,
  });

  final int mainCode;
  final int code;
  final String data;
  final List<Error> error;

  factory CompleteOrderModel.fromJson(Map<String, dynamic> json) =>
      CompleteOrderModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : json["data"],
        error: json["error"] == null
            ? null
            : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : data,
        "error": error,
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
