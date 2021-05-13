// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
    SearchModel({
        @required this.mainCode,
        @required this.code,
        @required this.data,
        @required this.error,
    });

    final int mainCode;
    final int code;
    final List<Datum> data;
    final List<Error> error;

    factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"] == null
            ? null
            : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
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
        @required this.id,
        @required this.name,
        @required this.details,
        @required this.price,
        @required this.categoryId,
        @required this.categoryName,
        @required this.providerId,
        @required this.providerName,
        @required this.providerCity,
        @required this.providerImage,
        @required this.providerBlocked,
        @required this.providerFavState,
        @required this.createdAt,
        @required this.favState,
        @required this.propertyValues,
        @required this.images,
    });

    final int id;
    final String name;
    final String details;
    final int price;
    final int categoryId;
    final String categoryName;
    final int providerId;
    final String providerName;
    final String providerCity;
    final String providerImage;
    final bool providerBlocked;
    final bool providerFavState;
    final String createdAt;
    final bool favState;
    final List<PropertyValue> propertyValues;
    final List<Image> images;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        details: json["details"] == null ? null : json["details"],
        price: json["price"] == null ? null : json["price"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        categoryName: json["category_name"] == null ? null : json["category_name"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        providerName: json["provider_name"] == null ? null : json["provider_name"],
        providerCity: json["provider_city"] == null ? null : json["provider_city"],
        providerImage: json["provider_image"] == null ? null : json["provider_image"],
        providerBlocked: json["provider_blocked"] == null ? null : json["provider_blocked"],
        providerFavState: json["provider_fav_state"] == null ? null : json["provider_fav_state"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        favState: json["fav_state"] == null ? null : json["fav_state"],
        propertyValues: json["property_values"] == null ? null : List<PropertyValue>.from(json["property_values"].map((x) => PropertyValue.fromJson(x))),
        images: json["images"] == null ? null : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "details": details == null ? null : details,
        "price": price == null ? null : price,
        "category_id": categoryId == null ? null : categoryId,
        "category_name": categoryName == null ? null : categoryName,
        "provider_id": providerId == null ? null : providerId,
        "provider_name": providerName == null ? null : providerName,
        "provider_city": providerCity == null ? null : providerCity,
        "provider_image": providerImage == null ? null : providerImage,
        "provider_blocked": providerBlocked == null ? null : providerBlocked,
        "provider_fav_state": providerFavState == null ? null : providerFavState,
        "created_at": createdAt == null ? null : createdAt,
        "fav_state": favState == null ? null : favState,
        "property_values": propertyValues == null ? null : List<dynamic>.from(propertyValues.map((x) => x.toJson())),
        "images": images == null ? null : List<dynamic>.from(images.map((x) => x.toJson())),
    };
}

class Image {
    Image({
        @required this.id,
        @required this.image,
    });

    final int id;
    final String image;

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"] == null ? null : json["id"],
        image: json["image"] == null ? null : json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "image": image == null ? null : image,
    };
}

class PropertyValue {
    PropertyValue({
        @required this.id,
        @required this.name,
        @required this.propertyId,
        @required this.propertyName,
    });

    final int id;
    final String name;
    final int propertyId;
    final String propertyName;

    factory PropertyValue.fromJson(Map<String, dynamic> json) => PropertyValue(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        propertyId: json["property_id"] == null ? null : json["property_id"],
        propertyName: json["property_name"] == null ? null : json["property_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "property_id": propertyId == null ? null : propertyId,
        "property_name": propertyName == null ? null : propertyName,
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
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
    );

    Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "value": value == null ? null : value,
    };
}
