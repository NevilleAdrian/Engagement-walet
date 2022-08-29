// To parse this JSON data, do
//
//     final searchFriends = searchFriendsFromJson(jsonString);

import 'dart:convert';

List<SearchFriends> searchFriendsFromJson(String str) => List<SearchFriends>.from(json.decode(str).map((x) => SearchFriends.fromJson(x)));

String searchFriendsToJson(List<SearchFriends> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchFriends {
  SearchFriends({
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.customerUniqueName,
    this.role,
    this.profileImage,
    this.activationStatus,
    this.isBiometrics,
    this.lastLogIn,
    this.customerAddress,
    this.dateCreated,
    this.storeId,
    this.subStoreId,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? customerUniqueName;
  String? role;
  String? profileImage;
  bool? activationStatus;
  bool? isBiometrics;
  DateTime? lastLogIn;
  List<dynamic>? customerAddress;
  DateTime? dateCreated;
  dynamic? storeId;
  dynamic? subStoreId;

  factory SearchFriends.fromJson(Map<String, dynamic> json) => SearchFriends(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    userName: json["userName"],
    customerUniqueName: json["customerUniqueName"],
    role: json["role"],
    profileImage: json["profileImage"],
    activationStatus: json["activationStatus"],
    isBiometrics: json["isBiometrics"],
    lastLogIn: DateTime.parse(json["lastLogIn"]),
    customerAddress: List<dynamic>.from(json["customerAddress"].map((x) => x)),
    dateCreated: DateTime.parse(json["dateCreated"]),
    storeId: json["storeId"],
    subStoreId: json["subStoreId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "userName": userName,
    "customerUniqueName": customerUniqueName,
    "role": role,
    "profileImage": profileImage,
    "activationStatus": activationStatus,
    "isBiometrics": isBiometrics,
    "lastLogIn": lastLogIn!.toIso8601String(),
    "customerAddress": List<dynamic>.from(customerAddress!.map((x) => x)),
    "dateCreated": dateCreated!.toIso8601String(),
    "storeId": storeId,
    "subStoreId": subStoreId,
  };
}
