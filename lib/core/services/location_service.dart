import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../service_import.dart';

void backgroundMain() {
  WidgetsFlutterBinding.ensureInitialized();
  LocationService().getLiveLocation();
}

class LocationService extends ServiceImport {
  Map<String, dynamic> busData;

  setBusData(Map<String, dynamic> data) {
    busData = data;
  }

  StreamSubscription<Position> positionStream;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  getLiveLocation() async {
    final hasPermission = await handlePermission();
    if (hasPermission) {
      print("has permission");
      positionStream =
          Geolocator.getPositionStream().listen((Position position) {
        print(position == null
            ? 'Unknown'
            : "My Location:" +
                position.latitude.toString() +
                ', ' +
                position.longitude.toString());
        Map<String, dynamic> data = {
          "bus": busData,
          "latitude": position.latitude.toString(),
          "longitude": position.longitude.toString(),
        };
        streamSocket.sendLocation(data);
      });
    }
  }

  Future<bool> handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("@@ location: service is not enabled");

      await dialogService.showDialog(
          description: "Please enable location",
          buttonNegativeTitle: "Cancel",
          showNegativeButton: true);

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        print('@@ Location services are disabled.');

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print(
          '@@ Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  void stop() {
    print("DRAINing");

    if (positionStream != null) {
      positionStream.cancel();
    }
    print("DRAINED");
  }

  Future<Position> getStaticLocation() async {
    final position = await _geolocatorPlatform.getCurrentPosition();
    return position;
  }
}
