// To parse this JSON data, do
//
//     final createChatModel = createChatModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateChatModel createChatModelFromJson(String str) =>
    CreateChatModel.fromJson(json.decode(str));

String createChatModelToJson(CreateChatModel data) =>
    json.encode(data.toJson());

class CreateChatModel {
  CreateChatModel({
    @required this.mainCode,
    @required this.code,
    @required this.data,
    @required this.error,
  });

  final int mainCode;
  final int code;
  final Data data;
  final List<Data> error;

  factory CreateChatModel.fromJson(Map<String, dynamic> json) =>
      CreateChatModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"] == null
            ? null
            : List<Data>.from(json["error"].map((x) => Data.fromJson(x))),
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
    @required this.conversationId,
  });

  final String key;
  final int conversationId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        key: json["key"] == null ? null : json["key"],
        conversationId:
            json["conversation_id"] == null ? null : json["conversation_id"],
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "conversation_id": conversationId == null ? null : conversationId,
      };
}
