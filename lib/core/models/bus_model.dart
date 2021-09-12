// To parse this JSON data, do
//
//     final bus = busFromJson(jsonString);

import 'dart:convert';

BusModel busFromJson(String str) => BusModel.fromJson(json.decode(str));

String busToJson(BusModel data) => json.encode(data.toJson());

class BusModel {
  BusModel({
    this.success,
    this.totalBus,
    this.data,
    this.code,
  });

  bool success;
  int totalBus;
  List<BusModelData> data;
  int code;

  factory BusModel.fromJson(Map<String, dynamic> json) => BusModel(
        success: json["success"] == null ? null : json["success"],
        totalBus: json["totalBus"] == null ? null : json["totalBus"],
        data: json["data"] == null
            ? null
            : List<BusModelData>.from(
                json["data"].map((x) => BusModelData.fromJson(x))),
        code: json["code"] == null ? null : json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "totalBus": totalBus == null ? null : totalBus,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "code": code == null ? null : code,
      };
}

class BusModelData {
  BusModelData({
    this.id,
    this.busType,
    this.busStops,
    this.busTimings,
    this.busProvider,
    this.busNumber,
    this.v,
  });

  String id;
  String busType;
  List<String> busStops;
  List<String> busTimings;
  String busProvider;
  String busNumber;
  int v;

  factory BusModelData.fromJson(Map<String, dynamic> json) => BusModelData(
        id: json["_id"] == null ? null : json["_id"],
        busType: json["busType"] == null ? null : json["busType"],
        busStops: json["busStops"] == null
            ? null
            : List<String>.from(json["busStops"].map((x) => x)),
        busTimings: json["busTimings"] == null
            ? null
            : List<String>.from(json["busTimings"].map((x) => x)),
        busProvider: json["busProvider"] == null ? null : json["busProvider"],
        busNumber: json["busNumber"] == null ? null : json["busNumber"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "busType": busType == null ? null : busType,
        "busStops": busStops == null
            ? null
            : List<dynamic>.from(busStops.map((x) => x)),
        "busTimings": busTimings == null
            ? null
            : List<dynamic>.from(busTimings.map((x) => x)),
        "busProvider": busProvider == null ? null : busProvider,
        "busNumber": busNumber == null ? null : busNumber,
        "__v": v == null ? null : v,
      };
}
