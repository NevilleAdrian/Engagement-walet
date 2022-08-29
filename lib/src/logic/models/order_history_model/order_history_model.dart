// To parse this JSON data, do
//
//     final orderHistoryModel = orderHistoryModelFromJson(jsonString);

import 'dart:convert';

List<OrderHistoryModel> orderHistoryModelFromJson(String str) => List<OrderHistoryModel>.from(json.decode(str).map((x) => OrderHistoryModel.fromJson(x)));

String orderHistoryModelToJson(List<OrderHistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderHistoryModel {
  OrderHistoryModel({
    this.orderStatus,
    this.deliveryDate,
    this.purchaseCode,
    this.customers,
    this.applicationUserId,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  String? orderStatus;
  DateTime? deliveryDate;
  String? purchaseCode;
  dynamic customers;
  String? applicationUserId;
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) => OrderHistoryModel(
    orderStatus: json["orderStatus"],
    deliveryDate: DateTime.parse(json["deliveryDate"]),
    purchaseCode: json["purchaseCode"],
    customers: json["customers"],
    applicationUserId: json["applicationUserId"],
    id: json["id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "orderStatus": orderStatus,
    "deliveryDate": deliveryDate!.toIso8601String(),
    "purchaseCode": purchaseCode,
    "customers": customers,
    "applicationUserId": applicationUserId,
    "id": id,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
  };
}
