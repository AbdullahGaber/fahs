// To parse this JSON data, do
//
//     final settingsModel = settingsModelFromJson(jsonString);

import 'dart:convert';

SettingsModel settingsModelFromJson(String str) => SettingsModel.fromJson(json.decode(str));

String settingsModelToJson(SettingsModel data) => json.encode(data.toJson());

class SettingsModel {
    SettingsModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    dynamic error;

    factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
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
        this.email,
        this.phone,
        this.distance,
        this.commission,
        this.bankName,
        this.bankNumber,
        this.activeOrdersCount,
        this.unpaidCommissions,
    });

    int id;
    String email;
    String phone;
    int distance;
    double commission;
    String bankName;
    String bankNumber;
    int activeOrdersCount;
    int unpaidCommissions;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        distance: json["distance"] == null ? null : json["distance"],
        commission: json["commission"] == null ? null : json["commission"].toDouble(),
        bankName: json["bank_name"] == null ? null : json["bank_name"],
        bankNumber: json["bank_number"] == null ? null : json["bank_number"],
        activeOrdersCount: json["active_orders_count"] == null ? null : json["active_orders_count"],
        unpaidCommissions: json["unpaid_commissions"] == null ? null : json["unpaid_commissions"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "distance": distance == null ? null : distance,
        "commission": commission == null ? null : commission,
        "bank_name": bankName == null ? null : bankName,
        "bank_number": bankNumber == null ? null : bankNumber,
        "active_orders_count": activeOrdersCount == null ? null : activeOrdersCount,
        "unpaid_commissions": unpaidCommissions == null ? null : unpaidCommissions,
    };
}
