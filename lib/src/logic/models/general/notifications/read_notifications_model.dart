// To parse this JSON data, do
//
//     final readNotificationsModel = readNotificationsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ReadNotificationsModel readNotificationsModelFromJson(String str) => ReadNotificationsModel.fromJson(json.decode(str));

String readNotificationsModelToJson(ReadNotificationsModel data) => json.encode(data.toJson());

class ReadNotificationsModel {
    ReadNotificationsModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    final int mainCode;
    final int code;
    final List<dynamic> data;
    final dynamic error;

    factory ReadNotificationsModel.fromJson(Map<String, dynamic> json) => ReadNotificationsModel(
        mainCode: json["mainCode"],
        code: json["code"],
        data: json["data"],
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode,
        "code": code,
        "data": data,
        "error": error,
    };
}

