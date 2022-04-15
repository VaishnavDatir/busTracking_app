// ignore_for_file: cancel_subscriptions, close_sinks

import 'dart:async';

import 'package:BusTracking_App/core/constants.dart';
import 'package:flutter_background/flutter_background.dart';
import 'package:geolocator/geolocator.dart';

import '../service_import.dart';

class LocationService extends ServiceImport {
  final androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: Constants.appName,
    notificationText: "Sharing location in background",
    notificationImportance: AndroidNotificationImportance.Default,
    notificationIcon: AndroidResource(
        name: 'background_icon',
        defType: 'drawable'), // Default is ic_launcher from folder mipmap
  );

  StreamSubscription<Position>? positionStream;

  getAndShareLiveLocation(Map<String, dynamic> bData) async {
    final hasPermission = await handlePermission();
    if (hasPermission) {
      print("has permission");
      positionStream =
          Geolocator.getPositionStream().listen((Position position) {
        print("My Location:" +
            position.latitude.toString() +
            ', ' +
            position.longitude.toString());
        Map<String, dynamic> data = {
          "type": userService.userDetails!.data!.type.toString(),
          "bus": bData,
          "latitude": position.latitude.toString(),
          "longitude": position.longitude.toString(),
        };
        streamSocket.sendLocation(data);
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
        print("My Live-Location:" +
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
        cancelTitle: "Cancel",
      );

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

  Future getStaticLocation() async {
    late Position position;
    bool isPermited = await handlePermission();
    if (isPermited) {
      position = await Geolocator.getCurrentPosition();
      print("Current Loc: " + position.toJson().toString());
    }
    return position;
  }

  startService(Map<String, dynamic> bData) async {
    try {
      await FlutterBackground.initialize(androidConfig: androidConfig);
      bool hasPermissions = await FlutterBackground.hasPermissions;
      if (hasPermissions) {
        final backgroundExecution =
            await FlutterBackground.enableBackgroundExecution();
        if (backgroundExecution) {
          locationService.getAndShareLiveLocation(bData);
        }
      }
      return true;
    } catch (e) {
      print("ERROR WHILE STATING BG SERVICE: " + e.toString());
      return false;
    }
  }

  void stopService() async {
    print("DRAINing");
    streamSocket.removeDriver();

    if (positionStream != null) {
      positionStream!.cancel();
    }

    // await FlutterBackground.initialize(androidConfig: androidConfig);
    bool enabled = FlutterBackground.isBackgroundExecutionEnabled;
    if (enabled) {
      await FlutterBackground.disableBackgroundExecution();
    }
    print("DRAINED");
  }
}
