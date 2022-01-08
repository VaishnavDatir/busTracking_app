import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

// import 'package:location/location.dart';

import '../locator.dart';
import '../service_import.dart';

void backgroundMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocatorInjector.setupLocator();
  LocationService().getLiveLocation();
}

class LocationService extends ServiceImport {
  Map<String, dynamic>? busData;

  String? userType;

  setBusData(Map<String, dynamic>? data, String type) {
    busData = data;
    userType = type;
  }

  StreamSubscription<Position>? positionStream;

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
          "type": userType,
          "bus": busData,
          "latitude": position.latitude.toString(),
          "longitude": position.longitude.toString(),
        };
        streamSocket!.sendLocation(data);
      });
    }
  }

  StreamController controller = StreamController.broadcast();

  StreamSubscription<Position>? mYositionStream;
  void streamClose() {
    if (!controller.isClosed) controller.stream.drain();
    if (mYositionStream != null) mYositionStream!.pause();
  }

  void streamStart() {
    if (controller.isClosed) controller.stream;
    if (mYositionStream == null) mYositionStream!.resume();
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

      await dialogService!.showDialog(
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

  Future<Position> getStaticLocation() async {
    /* await Location.instance.getLocation().then((value) =>
        print(value.latitude.toString() + "," + value.longitude.toString())); */
    final position = await Geolocator.getCurrentPosition();
    print("Current Loc: " + position.toJson().toString());
    return position;
  }

  startServiceInPlatform() async {
    try {
      var methodChannel = MethodChannel("com.example.BusTracking_App/Start");
      var calbackHandle = PluginUtilities.getCallbackHandle(backgroundMain)!;
      methodChannel.invokeMethod("startService", calbackHandle.toRawHandle());
    } catch (e) {
      print("ERROR WHILE STATING BG SERVICE: " + e.toString());
    }
    return true;
  }

  stopServiceInPlatform() {
    print("Stoping android service");
    var methodChannel = MethodChannel("com.example.BusTracking_App/Stop");
    // methodChannel.invokeMethod("stopService", -1.0.toDouble());
    methodChannel.invokeMethod("stopService");
    stop();
    // stop();
  }

  void stop() {
    print("DRAINing");
    streamSocket!.removeDriver();
    // stopServiceInPlatform();
    if (positionStream != null) {
      positionStream!.cancel();
    }
    print("DRAINED");
  }
}
