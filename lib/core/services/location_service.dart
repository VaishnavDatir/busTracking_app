import 'dart:async';

import 'package:BusTracking_App/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:location/location.dart';

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
          "type": userService.userDetails.data.type.toString(),
          "bus": busData,
          "latitude": position.latitude.toString(),
          "longitude": position.longitude.toString(),
        };
        streamSocket.sendLocation(data);
      });
    }
  }

  StreamController controller = StreamController.broadcast();

  StreamSubscription<Position> mYositionStream;
  void streamClose() {
    if (!controller.isClosed) controller.stream.drain();
    if (mYositionStream != null) mYositionStream.pause();
  }

  void streamStart() {
    if (controller.isClosed) controller.stream;
    if (mYositionStream == null) mYositionStream.resume();
  }

  getMyLiveLocation() async {
    final hasPermission = await handlePermission();
    if (hasPermission) {
      mYositionStream =
          Geolocator.getPositionStream().listen((Position position) {
        print(position == null
            ? 'Unknown'
            : "My Live-Location:" +
                position.latitude.toString() +
                ', ' +
                position.longitude.toString());
        controller.sink.add(position.toJson());
      });
    }
  }

  Future<bool> handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("@@ location: service is not enabled");

      await dialogService.showDialog(
          description: "Please enable location",
          buttonNegativeTitle: "Cancel",
          showNegativeButton: true);

      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
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
    streamSocket.removeDriver();
    if (positionStream != null) {
      positionStream.cancel();
    }
    print("DRAINED");
  }

  Future<Position> getStaticLocation() async {
    /* await Location.instance.getLocation().then((value) =>
        print(value.latitude.toString() + "," + value.longitude.toString())); */
    final position = await Geolocator.getCurrentPosition();
    print("Current Loc: " + position.toJson().toString());
    return position;
  }
}
