import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:stacked/stacked.dart';

import '../../../core/models/bus_model.dart';
import '../../../core/models/dialog_model.dart';
import '../../../core/models/stops_model.dart';
import '../../../core/models/userDetails_model.dart';
import '../../../core/routes/router_path.dart';
import '../../../core/service_import.dart';

class PassengerViewModel extends StreamViewModel with ServiceImport {
  Stream get stream => this._getLiveData();

  Stream _getLiveData() {
    return streamSocket.getResponse;
  }

  Stream get myStream => this._myGetLiveData();

  Stream _myGetLiveData() {
    print('this shit');
    return locationService.controller.stream;
  }

  String clientId;
  MapController _mapController;
  MapController get mapController => this._mapController;

  /* <----------------------- PAGE -------------------------> */

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController sourceTextController = TextEditingController();
  TextEditingController destinationTextController = TextEditingController();

  /* <------------------------------------------------------> */

  UserDetails _userDetails;
  UserDetails get userDetails => _userDetails;

  /* <----------------------- STOP -------------------------> */

  StopsData _sourceStop = StopsData(id: null, stopName: null, stopCity: null);
  StopsData get sourceStop => this._sourceStop;

  StopsData _destinationStop;
  StopsData get destinationStop => this._destinationStop;

  StopsData _selectedStop;

  /* <------------------------------------------------------> */

  /* <------------------------ BUS -------------------------> */

  bool _showBottomBusSheet = false;
  bool get showBottomBusSheet => this._showBottomBusSheet;

  BusModel _busModel;
  BusModel get busModel => this._busModel;

  List<BusModelData> _busModelData;
  List<BusModelData> get busModelData => this._busModelData;
  /* <------------------------------------------------------> */
  Position pos;

  getLoc() async {
    print("Getting loc");
    // _locationData = await locationService.getCurrentLocation();
    /*   print(_locationData.latitude.toString() +
        " " +
        _locationData.longitude.toString()); */
    pos = await locationService.getStaticLocation();
    mapController.move(LatLng(pos.latitude, pos.longitude), 16);

    print("got loc");

    notifyListeners();
  }

  /* wow(TickerProvider tccc) {
    print("in Wow");
    locationService.controller.stream.listen((event) {
      print("Data:" + event.toString());
      animatedMapMove(LatLng(event["latitude"], event["longitude"]), tccc);
    });
  } */

  void initializeScreen(
    MapController mapController,
  ) async {
    setBusy(true);
    _mapController = mapController;
    _userDetails = userService.userDetails;
    clientId = streamSocket.myClientId;

    if (_userDetails.success == false) {
      await dialogService.showDialog(
          description: _userDetails.message.toString() ??
              "There was an error while getting data.");
      handleLogout();
      return;
    }
    locationService.getMyLiveLocation();
    setBusy(false);
    await getLoc();
    // wow(tccc);
    notifyListeners();
  }

  showBusList() {
    navigationService.navigateTo(
      kBusListScreen,
    );
  }

  showStopList() {
    navigationService.navigateTo(kStopListScreen);
  }

  void handleLogout() {
    locationService.streamClose();
    authService.logout();
  }

  void handleSourceStopFieldTap({bool isDestination}) async {
    hideBottomBusSheet();
    await getStop();

    if (_selectedStop == null) {
      _sourceStop = _sourceStop;
    } else {
      if (isDestination) {
        _destinationStop = _selectedStop;
        destinationTextController.text = _destinationStop.stopName;
      } else {
        _sourceStop = _selectedStop;
        sourceTextController.text = _sourceStop.stopName;
      }
    }
    notifyListeners();
  }

  void serachBus() async {
    dialogService.showLoadingDialog();
    if (_sourceStop == _destinationStop) {
      await dialogService.showDialog(
          description: "Source and Destination stop cannot be same");
    } else if (_sourceStop != null && _destinationStop != null) {
      _busModel = await busService.searchBusBySourceAndDestination(
        sourceId: _sourceStop.id,
        destinationId: _destinationStop.id,
      );

      if (_busModel.success) {
        _busModelData = _busModel.data;
        _showBottomBusSheet = true;
      }
    } else {
      await dialogService.showDialog(
          description: "Please specify required stops");
    }
    notifyListeners();
    dialogService.dialogDismiss();
  }

  Future<StopsData> getStop() async {
    _selectedStop = await navigationService.navigateTo(kStopSearchScreen);
    return _selectedStop ?? StopsData();
  }

  void handleSwap() {
    if (_sourceStop != null || _destinationStop != null) {
      StopsData _tempStops;
      _tempStops = _sourceStop;
      _sourceStop = _destinationStop;
      _destinationStop = _tempStops;

      //Change text
      destinationTextController.text = _destinationStop?.stopName ?? "";
      sourceTextController.text = _sourceStop?.stopName ?? "";
    }
    notifyListeners();
  }

  void openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  void hideBottomBusSheet() {
    _showBottomBusSheet = false;
    notifyListeners();
  }

  handleOnBusTap(String busId) {
    navigationService.navigateTo(kBusDetailScreen, arguments: {
      "busId": busId,
      "sourceStop": _sourceStop.id,
      "destinationStop": _destinationStop.id,
    });
  }

  handleExit() async {
    AlertResponse exit = await dialogService.showDialog(
      title: "Exit",
      description: "Are you sure you want to exit?",
      showNegativeButton: true,
      buttonNegativeTitle: "Cancel",
      buttonTitle: "Yes",
    );
    if (exit.confirmed) {
      SystemNavigator.pop();
    }
  }

  fabClick(TickerProvider tc) async {
    dialogService.showLoadingDialog();
    pos = await locationService.getStaticLocation();
    dialogService.dialogDismiss();
    // mapController.move(LatLng(pos.latitude, pos.longitude), 16);
    animatedMapMove(LatLng(pos.latitude, pos.longitude), tc);
  }

  void animatedMapMove(LatLng destLocation, TickerProvider tcc) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final _latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: 15, end: 16);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: tcc);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
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
