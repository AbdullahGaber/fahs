// To parse this JSON data, do
//
//     final productByIdModel = productByIdModelFromJson(jsonString);

import 'dart:convert';

ProductByIdModel productByIdModelFromJson(String str) =>
    ProductByIdModel.fromJson(json.decode(str));

String productByIdModelToJson(ProductByIdModel data) =>
    json.encode(data.toJson());

class ProductByIdModel {
  ProductByIdModel({
    this.mainCode,
    this.code,
    this.data,
    this.error,
  });

  int mainCode;
  int code;
  Data data;
  dynamic error;

  factory ProductByIdModel.fromJson(Map<String, dynamic> json) =>
      ProductByIdModel(
          mainCode: json["mainCode"] == null ? null : json["mainCode"],
          code: json["code"] == null ? null : json["code"],
          data: json["data"] == null ? null : Data.fromJson(json["data"]),
          error: json["error"] == null
              ? null
              : List<Error>.from(json["error"].map((x) => Error.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
        "error": error,
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.details,
    this.price,
    this.categoryId,
    this.categoryName,
    this.providerId,
    this.providerName,
    this.providerCity,
    this.providerImage,
    this.providerBlocked,
    this.providerFavState,
    this.createdAt,
    this.favState,
    this.propertyValues,
    this.images,
  });

  int id;
  String name;
  String details;
  int price;
  int categoryId;
  String categoryName;
  int providerId;
  String providerName;
  String providerCity;
  String providerImage;
  bool providerBlocked;
  bool providerFavState;
  String createdAt;
  bool favState;
  List<PropertyValue> propertyValues;
  List<Image> images;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        details: json["details"] == null ? null : json["details"],
        price: json["price"] == null ? null : json["price"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        categoryName:
            json["category_name"] == null ? null : json["category_name"],
        providerId: json["provider_id"] == null ? null : json["provider_id"],
        providerName:
            json["provider_name"] == null ? null : json["provider_name"],
        providerCity:
            json["provider_city"] == null ? null : json["provider_city"],
        providerImage:
            json["provider_image"] == null ? null : json["provider_image"],
        providerBlocked:
            json["provider_blocked"] == null ? null : json["provider_blocked"],
        providerFavState: json["provider_fav_state"] == null
            ? null
            : json["provider_fav_state"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        favState: json["fav_state"] == null ? null : json["fav_state"],
        propertyValues: json["property_values"] == null
            ? null
            : List<PropertyValue>.from(
                json["property_values"].map((x) => PropertyValue.fromJson(x))),
        images: json["images"] == null
            ? null
            : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
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
        "provider_fav_state":
            providerFavState == null ? null : providerFavState,
        "created_at": createdAt == null ? null : createdAt,
        "fav_state": favState == null ? null : favState,
        "property_values": propertyValues == null
            ? null
            : List<dynamic>.from(propertyValues.map((x) => x.toJson())),
        "images": images == null
            ? null
            : List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Image {
  Image({
    this.id,
    this.image,
  });

  int id;
  String image;

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
    this.id,
    this.name,
    this.propertyId,
    this.propertyName,
  });

  int id;
  String name;
  int propertyId;
  String propertyName;

  factory PropertyValue.fromJson(Map<String, dynamic> json) => PropertyValue(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        propertyId: json["property_id"] == null ? null : json["property_id"],
        propertyName:
            json["property_name"] == null ? null : json["property_name"],
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
