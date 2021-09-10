// To parse this JSON data, do
//
//     final stops = stopsFromJson(jsonString);

import 'dart:convert';

Stops stopsFromJson(String str) => Stops.fromJson(json.decode(str));

String stopsToJson(Stops data) => json.encode(data.toJson());

class Stops {
  Stops({
    this.success,
    this.totalStops,
    this.data,
    this.code,
  });

  bool success;
  int totalStops;
  List<StopsData> data;
  int code;

  factory Stops.fromJson(Map<String, dynamic> json) => Stops(
        success: json["success"],
        totalStops: json["totalStops"],
        data: List<StopsData>.from(
            json["data"].map((x) => StopsData.fromJson(x))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "totalStops": totalStops,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "code": code,
      };
}

class StopsData {
  StopsData({
    this.stopLocation,
    this.id,
    this.stopName,
    this.stopCity,
    this.v,
  });

  StopLocation stopLocation;
  String id;
  String stopName;
  String stopCity;
  int v;

  factory StopsData.fromJson(Map<String, dynamic> json) => StopsData(
        stopLocation: StopLocation.fromJson(json["stopLocation"]),
        id: json["_id"],
        stopName: json["stopName"],
        stopCity: json["stopCity"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "stopLocation": stopLocation.toJson(),
        "_id": id,
        "stopName": stopName,
        "stopCity": stopCity,
        "__v": v,
      };
}

class StopLocation {
  StopLocation({
    this.coordinates,
  });

  List<double> coordinates;

  factory StopLocation.fromJson(Map<String, dynamic> json) => StopLocation(
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}
