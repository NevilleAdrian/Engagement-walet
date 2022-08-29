// To parse this JSON data, do
//
//     final paymentOptions = paymentOptionsFromJson(jsonString);

import 'dart:convert';

List<PaymentOptions> paymentOptionsFromJson(String str) => List<PaymentOptions>.from(json.decode(str).map((x) => PaymentOptions.fromJson(x)));

String paymentOptionsToJson(List<PaymentOptions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentOptions {
  PaymentOptions({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory PaymentOptions.fromJson(Map<String, dynamic> json) => PaymentOptions(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
