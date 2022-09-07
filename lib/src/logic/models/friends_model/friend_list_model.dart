// To parse this JSON data, do
//
//     final friendsList = friendsListFromJson(jsonString);

import 'dart:convert';

List<FriendsList> friendsListFromJson(String str) => List<FriendsList>.from(
    json.decode(str).map((x) => FriendsList.fromJson(x)));

String friendsListToJson(List<FriendsList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FriendsList {
  FriendsList({
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.userId,
    this.accepted,
  });

  String? email;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? userId;
  bool? accepted;

  factory FriendsList.fromJson(Map<String, dynamic> json) => FriendsList(
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        userId: json["userId"],
        accepted: json["accepted"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "userId": userId,
        "accepted": accepted,
      };
}
