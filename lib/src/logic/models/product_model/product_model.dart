// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    this.id,
    this.name,
    this.unitPrice,
    this.quantity,
    this.coverImage,
    this.images,
    this.code,
    this.description,
    this.storeId,
    this.subStoreId,
    this.productCategoryId,
  });

  int? id;
  String? name;
  int? unitPrice;
  int? quantity;
  String? coverImage;
  List<String>? images;
  String? code;
  String? description;
  int? storeId;
  int? subStoreId;
  int? productCategoryId;

  factory ProductModel.fromJson(Map<String, dynamic> json){
     print('images: ${json["coverImage"]}');
    return  ProductModel(
      id: json["id"],
      name: json["name"],
      unitPrice: json["unitPrice"],
      quantity: json["quantity"],
      coverImage: json["coverImage"] == null || json["coverImage"] == '' || json["coverImage"] == 'Invalid Operation! an exception has occured'? 'https://images.pexels.com/photos/3819969/pexels-photo-3819969.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2': json["coverImage"] ,
      images: List<String>.from(json["images"].map((x) => x) ?? []),
      code: json["code"],
      description: json["description"],
      storeId: json["storeId"],
      subStoreId: json["subStoreId"],
      productCategoryId: json["productCategoryId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "unitPrice": unitPrice,
    "quantity": quantity,
    "coverImage": coverImage,
  "images": List<dynamic>.from(images!.map((x) => x)),
    "code": code,
    "description": description,
    "storeId": storeId,
    "subStoreId": subStoreId,
    "productCategoryId": productCategoryId,
  };
}
