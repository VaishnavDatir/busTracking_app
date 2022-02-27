// To parse this JSON data, do
//
//     final busDetailModel = busDetailModelFromJson(jsonString);

import 'dart:convert';

import './stops_model.dart';

BusDetailModel busDetailModelFromJson(String str) =>
    BusDetailModel.fromJson(json.decode(str));

String busDetailModelToJson(BusDetailModel data) => json.encode(data.toJson());

class BusDetailModel {
  BusDetailModel({
    this.success,
    this.busDetailData,
  });

  bool? success;
  BusDetailData? busDetailData;

  factory BusDetailModel.fromJson(Map<String, dynamic> json) => BusDetailModel(
        success: json["success"] == null ? null : json["success"],
        busDetailData: json["busDetailData"] == null
            ? null
            : BusDetailData.fromJson(json["busDetailData"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "busDetailData": busDetailData == null ? null : busDetailData!.toJson(),
      };
}

class BusDetailData {
  BusDetailData({
    this.id,
    this.busType,
    this.busStops,
    this.busTimings,
    this.busProvider,
    this.busNumber,
    this.activeDrivers,
    this.v,
  });

  String? id;
  String? busType;
  List<StopsData>? busStops;
  List<String>? busTimings;
  String? busProvider;
  String? busNumber;
  List<String>? activeDrivers;

  int? v;

  factory BusDetailData.fromJson(Map<String, dynamic> json) => BusDetailData(
        id: json["_id"] == null ? null : json["_id"],
        busType: json["busType"] == null ? null : json["busType"],
        busStops: json["busStops"] == null
            ? null
            : List<StopsData>.from(
                json["busStops"].map((x) => StopsData.fromJson(x))),
        busTimings: json["busTimings"] == null
            ? null
            : List<String>.from(json["busTimings"].map((x) => x)),
        busProvider: json["busProvider"] == null ? null : json["busProvider"],
        busNumber: json["busNumber"] == null ? null : json["busNumber"],
        activeDrivers: json["activeDrivers"] == null
            ? null
            : List<String>.from(json["activeDrivers"].map((x) => x)),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "busType": busType == null ? null : busType,
        "busStops": busStops == null
            ? null
            : List<dynamic>.from(busStops!.map((x) => x.toJson())),
        "busTimings": busTimings == null
            ? null
            : List<dynamic>.from(busTimings!.map((x) => x)),
        "busProvider": busProvider == null ? null : busProvider,
        "busNumber": busNumber == null ? null : busNumber,
        "__v": v == null ? null : v,
      };
}
