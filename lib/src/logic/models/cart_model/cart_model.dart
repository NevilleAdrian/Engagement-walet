// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

import 'dart:ui';

List<CartModel> cartModelFromJson(String str) => List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
  CartModel({
    this.id,
    this.image,
    this.product,
    this.quantity,
    this.amount,
  });

  String? id;
  String? image;
  String? product;
  int? quantity;
  int? amount;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json["id"],
    image: json["image"],
    product: json["product"],
    quantity: json["quantity"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "product": product,
    "quantity": quantity,
    "amount": amount,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CartModel &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              image == other.image &&
              product == other.product &&
              quantity == other.quantity &&
              amount == other.amount ;

  @override
  int get hashCode => hashValues(id, image, product, quantity, amount);
}
