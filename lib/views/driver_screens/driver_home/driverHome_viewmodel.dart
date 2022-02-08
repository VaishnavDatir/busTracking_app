import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../core/models/userDetails_model.dart';
import '../../../core/service_import.dart';
import '../../components/setup_dialog_ui.dart';

class DriverHomeViewModel extends StreamViewModel with ServiceImport {
  @override
  Stream get stream => this._getLiveData();

  Stream _getLiveData() {
    return streamSocket!.getResponse;
  }

  UserDetails? _userDetails;
  UserDetails? get userDetails => _userDetails;

  bool? _isDriverOnBus;
  bool? get isDriverOnBus => _isDriverOnBus;

  String? clientId;

  // loc.Location _location = loc.Location();
  /*  loc.LocationData _locationData;
  loc.LocationData get locationData => this._locationData; */
  MapController? _mapController;
  MapController? get mapController => this._mapController;

  late Position pos;

  getLoc() async {
    print("Getting loc");
    // _locationData = await locationService.getCurrentLocation();
    /*   print(_locationData.latitude.toString() +
        " " +
        _locationData.longitude.toString()); */
    pos = await locationService!.getStaticLocation();
    mapController!.move(LatLng(pos.latitude, pos.longitude), 16);

    print("got loc");

    notifyListeners();
  }

  initializeScreen(MapController? mapController) async {
    _mapController = mapController;
    setBusy(true);

    _userDetails = userService!.userDetails;
    if (_userDetails!.success == false) {
      await dialogService.showDialog(
          description: _userDetails?.message.toString() ??
              "There was an error while getting data.");
      handleLogout();
      return;
    }
    _isDriverOnBus = _userDetails!.data!.isActive;

    clientId = streamSocket!.myClientId;
    print(clientId ?? "no id");

    setBusy(false);

    notifyListeners();
    await getLoc();
  }

  changeIsDriverOnBus() async {
    dialogService.showCustomDialog(variant: DialogType.loading);

    Map<String, dynamic> response = await (userService!.removeDriverOnBus());

    // locationService.stop();
    locationService!.stopService();

    // streamSocket.socketDisconnect();

    await userService!.getUserData();
    _isDriverOnBus = _userDetails!.data!.isActive;

    await dialogService.showDialog(
        title: response["success"].toString(),
        description: response["message"]);

    initializeScreen(mapController);

    notifyListeners();

    navigationService.back();
  }

  showBusList() {
    navigationService.navigateTo(Routes.busListScreen,
        arguments: BusListScreenArguments(screenData: {}));
  }

  showStopList() {
    navigationService.navigateTo(Routes.stopsListScreen);
  }

  handleGoOnDuty() async {
    if (_isDriverOnBus!) {
      await dialogService.showDialog(
          description:
              "Your already on duty.\nTo select new bus go off-duty and then select.");
    } else {
      await navigationService.navigateTo(Routes.busListScreen,
          arguments: BusListScreenArguments(screenData: {
            "driverGoingOnDuty": true,
          }));
    }
  }

  handleLogout() {
    authService!.logout();
  }

  handleExit() async {
    var exit = await dialogService.showDialog(
      title: "Exit",
      description: "Are you sure you want to exit?",
      cancelTitle: "Canecl",
      buttonTitle: "Yes",
    );

    if (exit!.confirmed) {
      SystemNavigator.pop();
    }
  }

  fabClick(TickerProvider tc) async {
    dialogService.showCustomDialog(variant: DialogType.loading);

    pos = await locationService!.getStaticLocation();
    navigationService.back();

    // mapController.move(LatLng(pos.latitude, pos.longitude), 16);
    animatedMapMove(LatLng(pos.latitude, pos.longitude), tc);
  }

  void animatedMapMove(LatLng destLocation, TickerProvider tcc) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final _latTween = Tween<double>(
        begin: mapController!.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapController!.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: 16, end: 16);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: tcc);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController!.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }
}
