import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../service_import.dart';

void backgroundMain() {
  WidgetsFlutterBinding.ensureInitialized();
  // LocationService.instance().getLocation();
  LocationService().getLocation();
}

class LocationService extends ServiceImport {
  // factory LocationService.instance() => _instance;

  // LocationService._internal();

  // static final _instance = LocationService._internal();

  Location myLocation = Location();
  StreamSubscription<LocationData> locationSubscription;
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  getLocation() async {
    _permissionGranted = await myLocation.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await myLocation.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        /*  Fluttertoast.showToast(
          msg: "Please grant the permission for location",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[800],
          textColor: Colors.white,
          fontSize: 14,
        ); */
        await dialogService.showDialog(
            description: "Please grant the permission for location");
        return false;
      }
    }
    _serviceEnabled = await myLocation.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await myLocation.requestService();
      if (!_serviceEnabled) {
        /*  Fluttertoast.showToast(
          msg: "Please turn on location",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red[800],
          textColor: Colors.white,
          fontSize: 14,
        ); */
        await dialogService.showDialog(description: "Please turn on location");
        return false;
      }
    }
    //WORKING BEST
    locationSubscription =
        myLocation.onLocationChanged.listen((LocationData currentLoction) {
      print("MY LOCATION");
      print("Accuracy: " +
          currentLoction.accuracy.toStringAsFixed(0) +
          " latitude: " +
          currentLoction.latitude.toString() +
          " longitude:" +
          currentLoction.longitude.toString());
      /*   UserManagement().updateLocation(
        currentLoction.latitude,
        currentLoction.longitude,
        currentLoction.accuracy,
      ); */
    });
    return true;
  }

  void stop() {
    print("DRAINing");
    if (locationSubscription != null) {
      locationSubscription.cancel();
    }
    print("DRAINED");
  }
}
