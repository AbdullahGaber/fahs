// To parse this JSON data, do
//
//     final myConversationsModel = myConversationsModelFromJson(jsonString);

import 'dart:convert';

MyConversationsModel myConversationsModelFromJson(String str) =>
    MyConversationsModel.fromJson(json.decode(str));

String myConversationsModelToJson(MyConversationsModel data) =>
    json.encode(data.toJson());

class MyConversationsModel {
  MyConversationsModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  List<Datum> data;
  List<Error> error;

  factory MyConversationsModel.fromJson(Map<String, dynamic> json) =>
      MyConversationsModel(
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
    this.userId,
    this.userName,
    this.userPhone,
    this.userImage,
    this.providerId,
    this.providerName,
    this.providerPhone,
    this.providerImage,
    this.lastMessage,
    this.createdAt,
  });

  final int id;
  final int userId;
  final String userName;
  final String userPhone;
  final String userImage;
  final int providerId;
  final String providerName;
  final String providerPhone;
  final String providerImage;
  final String lastMessage;
  final String createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        userName: json["user_name"] == null ? null : json["user_name"],
        userPhone: json["user_phone"] == null ? null : json["user_phone"],
        userImage: json["user_image"] == null ? null : json["user_image"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        providerName:
            json["provider_name"] == null ? null : json["provider_name"],
        providerPhone:
            json["provider_phone"] == null ? null : json["provider_phone"],
        providerImage:
            json["provider_image"] == null ? null : json["provider_image"],
        lastMessage: json["last_message"] == null ? null : json["last_message"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "user_name": userName == null ? null : userName,
        "user_phone": userPhone == null ? null : userPhone,
        "user_image": userImage == null ? null : userImage,
        "provider_id": providerId == null ? null : providerId,
        "provider_name": providerName == null ? null : providerName,
        "provider_phone": providerPhone == null ? null : providerPhone,
        "provider_image": providerImage == null ? null : providerImage,
        "last_message": lastMessage == null ? null : lastMessage,
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
