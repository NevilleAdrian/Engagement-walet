// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.firstName,
    this.lastName,
    this.role,
    this.alternateEmail,
    this.pin,
    this.passwordResetNeeded,
    this.profileImage,
    this.customerUniqueName,
    this.createdBy,
    this.approvedBy,
    this.customerAddress,
    this.activationStatus,
    this.isBiometrics,
    this.lastLogIn,
    this.dailyLoginCount,
    this.dateCreated,
    this.storeId,
    this.store,
    this.subStoreId,
    this.subStore,
    this.purchases,
    this.orders,
    this.customerScoreBoards,
    this.customerOrderAddress,
    this.id,
    this.userName,
    this.normalizedUserName,
    this.email,
    this.normalizedEmail,
    this.emailConfirmed,
    this.passwordHash,
    this.securityStamp,
    this.concurrencyStamp,
    this.phoneNumber,
    this.phoneNumberConfirmed,
    this.twoFactorEnabled,
    this.lockoutEnd,
    this.lockoutEnabled,
    this.accessFailedCount,
  });

  String? firstName;
  String? lastName;
  String? role;
  String? alternateEmail;
  String? pin;
  bool? passwordResetNeeded;
  String? profileImage;
  String? customerUniqueName;
  String? createdBy;
  String? approvedBy;
  List<String>? customerAddress;
  bool? activationStatus;
  bool? isBiometrics;
  DateTime? lastLogIn;
  int? dailyLoginCount;
  DateTime? dateCreated;
  int? storeId;
  dynamic store;
  dynamic subStoreId;
  dynamic subStore;
  dynamic purchases;
  dynamic orders;
  dynamic customerScoreBoards;
  dynamic customerOrderAddress;
  String? id;
  String? userName;
  String? normalizedUserName;
  String? email;
  String? normalizedEmail;
  bool? emailConfirmed;
  String? passwordHash;
  String? securityStamp;
  String? concurrencyStamp;
  String? phoneNumber;
  bool? phoneNumberConfirmed;
  bool? twoFactorEnabled;
  dynamic lockoutEnd;
  bool? lockoutEnabled;
  int? accessFailedCount;

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["firstName"],
        lastName: json["lastName"],
        role: json["role"],
        alternateEmail: json["alternateEmail"],
        pin: json["pin"],
        passwordResetNeeded: json["passwordResetNeeded"],
        profileImage: json["profileImage"],
        customerUniqueName: json["customerUniqueName"],
        createdBy: json["createdBy"],
        approvedBy: json["approvedBy"],
        customerAddress:
            List<String>.from(json["customerAddress"].map((x) => x)),
        activationStatus: json["activationStatus"],
        isBiometrics: json["isBiometrics"],
        lastLogIn: DateTime.parse(json["lastLogIn"]),
        dailyLoginCount: json["dailyLoginCount"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        storeId: json["storeId"],
        store: json["store"],
        subStoreId: json["subStoreId"],
        subStore: json["subStore"],
        purchases: json["purchases"],
        orders: json["orders"],
        customerScoreBoards: json["customerScoreBoards"],
        customerOrderAddress: json["customerOrderAddress"],
        id: json["id"],
        userName: json["userName"],
        normalizedUserName: json["normalizedUserName"],
        email: json["email"],
        normalizedEmail: json["normalizedEmail"],
        emailConfirmed: json["emailConfirmed"],
        passwordHash: json["passwordHash"],
        securityStamp: json["securityStamp"],
        concurrencyStamp: json["concurrencyStamp"],
        phoneNumber: json["phoneNumber"],
        phoneNumberConfirmed: json["phoneNumberConfirmed"],
        twoFactorEnabled: json["twoFactorEnabled"],
        lockoutEnd: json["lockoutEnd"],
        lockoutEnabled: json["lockoutEnabled"],
        accessFailedCount: json["accessFailedCount"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "role": role,
        "alternateEmail": alternateEmail,
        "pin": pin,
        "passwordResetNeeded": passwordResetNeeded,
        "profileImage": profileImage,
        "customerUniqueName": customerUniqueName,
        "createdBy": createdBy,
        "approvedBy": approvedBy,
        "customerAddress": List<dynamic>.from(customerAddress!.map((x) => x)),
        "activationStatus": activationStatus,
        "isBiometrics": isBiometrics,
        "lastLogIn": lastLogIn!.toIso8601String(),
        "dailyLoginCount": dailyLoginCount,
        "dateCreated": dateCreated!.toIso8601String(),
        "storeId": storeId,
        "store": store,
        "subStoreId": subStoreId,
        "subStore": subStore,
        "purchases": purchases,
        "orders": orders,
        "customerScoreBoards": customerScoreBoards,
        "customerOrderAddress": customerOrderAddress,
        "id": id,
        "userName": userName,
        "normalizedUserName": normalizedUserName,
        "email": email,
        "normalizedEmail": normalizedEmail,
        "emailConfirmed": emailConfirmed,
        "passwordHash": passwordHash,
        "securityStamp": securityStamp,
        "concurrencyStamp": concurrencyStamp,
        "phoneNumber": phoneNumber,
        "phoneNumberConfirmed": phoneNumberConfirmed,
        "twoFactorEnabled": twoFactorEnabled,
        "lockoutEnd": lockoutEnd,
        "lockoutEnabled": lockoutEnabled,
        "accessFailedCount": accessFailedCount,
      };
}
