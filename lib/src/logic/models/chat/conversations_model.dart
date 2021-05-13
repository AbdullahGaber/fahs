// To parse this JSON data, do
//
//     final conversationsModel = conversationsModelFromJson(jsonString);

import 'dart:convert';

ConversationMessagesModel conversationsModelFromJson(String str) =>
    ConversationMessagesModel.fromJson(json.decode(str));

String conversationsModelToJson(ConversationMessagesModel data) =>
    json.encode(data.toJson());

class ConversationMessagesModel {
  ConversationMessagesModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Datum> data;
  List<Error> error;

  factory ConversationMessagesModel.fromJson(Map<String, dynamic> json) =>
      ConversationMessagesModel(
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
    this.id,
    this.message,
    this.seen,
    this.file,
    this.senderId,
    this.senderName,
    this.senderImage,
    this.createdAt,
  });

  int id;
  String message;
  int seen;
  String file;
  int senderId;
  String senderName;
  String senderImage;
  String createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        message: json["message"] == null ? null : json["message"],
        seen: json["seen"] == null ? null : json["seen"],
        file: json["file"] == null ? null : json["file"],
        senderId: json["sender_id"] == null ? null : json["sender_id"],
        senderName: json["sender_name"] == null ? null : json["sender_name"],
        senderImage: json["sender_image"] == null ? null : json["sender_image"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "message": message == null ? null : message,
        "seen": seen == null ? null : seen,
        "file": file == null ? null : file,
        "sender_id": senderId == null ? null : senderId,
        "sender_name": senderName == null ? null : senderName,
        "sender_image": senderImage == null ? null : senderImage,
        "created_at": createdAt == null ? null : createdAt,
      };
}

class Error {
  Error({
    this.key,
    this.value,
  });

  final String key;
  final String value;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "value": value == null ? null : value,
      };
}
