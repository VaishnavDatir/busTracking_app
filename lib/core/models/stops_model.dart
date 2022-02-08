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

  bool? success;
  int? totalStops;
  List<StopsData>? data;
  int? code;

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
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
      };
}

class StopsData {
  StopsData({
    this.id,
    this.stopName,
    this.stopLocation,
    this.stopCity,
  });
  late final String? id;
  late final String? stopName;
  late final StopLocation? stopLocation;
  late final String? stopCity;

  StopsData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    stopName = json['stopName'];
    stopLocation = StopLocation.fromJson(json['stopLocation']);
    stopCity = json['stopCity'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['stopName'] = stopName;
    _data['stopLocation'] = stopLocation?.toJson();
    _data['stopCity'] = stopCity;
    return _data;
  }
}

class StopLocation {
  StopLocation({
    required this.coordinates,
  });
  late final List<double?> coordinates;

  StopLocation.fromJson(Map<String, dynamic> json) {
    coordinates = List.castFrom<dynamic, Null>(json['coordinates']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['coordinates'] = coordinates;
    return _data;
  }
}
