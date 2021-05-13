// To parse this JSON data, do
//
//     final splashsModel = splashsModelFromJson(jsonString);

import 'dart:convert';

SplashsModel splashsModelFromJson(String str) => SplashsModel.fromJson(json.decode(str));

String splashsModelToJson(SplashsModel data) => json.encode(data.toJson());

class SplashsModel {
    SplashsModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    dynamic error;

    factory SplashsModel.fromJson(Map<String, dynamic> json) => SplashsModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
    };
}

class Datum {
    Datum({
        this.id,
        this.productId,
        this.link,
        this.image,
    });

    int id;
    int productId;
    String link;
    String image;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        link: json["link"] == null ? null : json["link"],
        image: json["image"] == null ? null : json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "product_id": productId == null ? null : productId,
        "link": link == null ? null : link,
        "image": image == null ? null : image,
    };
}
