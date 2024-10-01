import 'dart:convert';

SignInModel signInModelFromJson(String str) => SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
  final bool? status;
  final int? statusCode;
  final Data? data;

  SignInModel({
    this.status,
    this.statusCode,
    this.data,
  });

  SignInModel copyWith({
    bool? status,
    int? statusCode,
    Data? data,
  }) =>
      SignInModel(
        status: status ?? this.status,
        statusCode: statusCode ?? this.statusCode,
        data: data ?? this.data,
      );

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        status: json["status"],
        statusCode: json["statusCode"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "data": data?.toJson(),
      };
}

class Data {
  final User? user;
  final String? token;

  Data({
    this.user,
    this.token,
  });

  Data copyWith({
    User? user,
    String? token,
  }) =>
      Data(
        user: user ?? this.user,
        token: token ?? this.token,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
      };
}

class User {
  final String? address;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  User({
    this.address,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  User copyWith({
    String? address,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      User(
        address: address ?? this.address,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        address: json["address"],
        id: json["_id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
