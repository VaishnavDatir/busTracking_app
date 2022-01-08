// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

import 'dart:convert';

UserDetails userDetailsFromJson(String str) =>
    UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
  UserDetails({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.location,
    this.id,
    this.name,
    this.email,
    this.password,
    this.type,
    this.isActive,
    this.v,
    this.onBus,
  });

  Location? location;
  String? id;
  String? name;
  String? email;
  String? password;
  String? type;
  bool? isActive;
  int? v;
  String? onBus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        location: Location.fromJson(json["location"]),
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        type: json["type"],
        isActive: json["isActive"],
        v: json["__v"],
        onBus: json["onBus"],
      );

  Map<String, dynamic> toJson() => {
        "location": location!.toJson(),
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "type": type,
        "isActive": isActive,
        "__v": v,
        "onBus": onBus,
      };
}

class Location {
  Location({
    this.coordinates,
  });

  List<double>? coordinates;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
