import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../core/models/bus_model.dart';
import '../../../core/models/stops_model.dart';
import '../../../core/models/userDetails_model.dart';
import '../../../core/service_import.dart';
import '../../../theme/colors.dart';
import '../../../theme/dimensions.dart';
import '../../components/setup_dialog_ui.dart';

class PassengerViewModel extends StreamViewModel with ServiceImport {
  Stream get stream => this._getLiveData();

  Stream _getLiveData() {
    return streamSocket.getResponse;
  }

  Stream get myStream => this._myGetLiveData();

  Stream _myGetLiveData() {
    return locationService.controller.stream;
  }

  String? clientId;
  MapController? _mapController;
  MapController? get mapController => this._mapController;

  /* <----------------------- PAGE -------------------------> */

  GlobalKey<ScaffoldState>? scaffoldKey;

  TextEditingController sourceTextController = TextEditingController();
  TextEditingController destinationTextController = TextEditingController();

  /* <------------------------------------------------------> */

  UserDetails? _userDetails;
  UserDetails? get userDetails => _userDetails;

  /* <----------------------- STOP -------------------------> */

  StopsData? _sourceStop = StopsData(id: null, stopName: null, stopCity: null);
  StopsData? get sourceStop => this._sourceStop;

  StopsData? _destinationStop;
  StopsData? get destinationStop => this._destinationStop;

  late StopsData? _selectedStop;

  /* <------------------------------------------------------> */

  /* <------------------------ BUS -------------------------> */

  bool _showBottomBusSheet = false;
  bool get showBottomBusSheet => this._showBottomBusSheet;

  BusModel? _busModel;
  BusModel? get busModel => this._busModel;

  List<BusModelData>? _busModelData;
  List<BusModelData>? get busModelData => this._busModelData;
  /* <------------------------------------------------------> */
  late Position pos;

  TickerProvider? _tickerProvider;

  String? _selectedBusClientId = "";
  String? get selectedBusClientId => this._selectedBusClientId;

  @override
  void dispose() {
    super.dispose();
    print("disposing...");
    stream.drain();
    myStream.drain();
    _getLiveData().drain();
    _myGetLiveData().drain();
  }

  getLoc() async {
    print("Getting loc");
    // _locationData = await locationService.getCurrentLocation();
    /*   print(_locationData.latitude.toString() +
        " " +
        _locationData.longitude.toString()); */
    pos = await locationService.getStaticLocation();
    _mapController!.move(LatLng(pos.latitude, pos.longitude), 16);

    print("got loc");

    notifyListeners();
  }

  void initializeScreen(
      {MapController? mapController,
      TickerProvider? tickerProvicer,
      BuildContext? context,
      GlobalKey<ScaffoldState>? inscaffoldKey}) async {
    setBusy(true);
    scaffoldKey = inscaffoldKey;
    _mapController = mapController;
    _tickerProvider = tickerProvicer;
    _selectedBusClientId = "";
    _isShowingBottomSheet = false;

    clientId = streamSocket.myClientId;
    _userDetails = userService.userDetails;

    if (_userDetails!.success == false) {
      await dialogService.showDialog(
          description: _userDetails?.message.toString() ??
              "There was an error while getting data.");
      handleLogout();
      return;
    }
    locationService.getMyLiveLocation();
    setBusy(false);
    await getLoc();

    notifyListeners();
  }

  showBusList() {
    navigationService.navigateTo(Routes.busListScreen,
        arguments: BusListScreenArguments(screenData: {}));
  }

  showStopList() {
    navigationService.navigateTo(Routes.stopsListScreen);
  }

  void handleLogout() {
    locationService.streamClose();
    authService.logout();
  }

  void handleSourceStopFieldTap({bool? isDestination}) async {
    hideBottomBusSheet();
    await getStop();

    if (_selectedStop == null) {
      _sourceStop = _sourceStop;
    } else {
      if (isDestination!) {
        _destinationStop = _selectedStop;
        destinationTextController.text = _destinationStop!.stopName!;
      } else {
        _sourceStop = _selectedStop;
        sourceTextController.text = _sourceStop!.stopName!;
      }
    }
    notifyListeners();
  }

  void serachBus() async {
    dialogService.showCustomDialog(variant: DialogType.loading);

    if (_sourceStop == _destinationStop) {
      await dialogService.showDialog(
          description: "Source and Destination stop cannot be same");
    } else if (_sourceStop != null && _destinationStop != null) {
      _busModel = await busService.searchBusBySourceAndDestination(
        sourceId: _sourceStop!.id,
        destinationId: _destinationStop!.id,
      );

      if (_busModel!.success!) {
        _busModelData = _busModel!.data;
        _showBottomBusSheet = true;
        handleMapTap();
      }
    } else {
      await dialogService.showDialog(
          description: "Please specify required stops");
    }
    notifyListeners();
    navigationService.back();
  }

  Future<StopsData> getStop() async {
    // _selectedStop = await (navigationService!.navigateTo(kStopSearchScreen));
    _selectedStop = await navigationService.navigateTo(Routes.stopSearchScreen)
        as StopsData?;

    return _selectedStop ?? StopsData();
  }

  void handleSwap() {
    if (_sourceStop != null || _destinationStop != null) {
      StopsData? _tempStops;
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
    scaffoldKey!.currentState!.openDrawer();
  }

  void hideBottomBusSheet() {
    _showBottomBusSheet = false;
    notifyListeners();
  }

  handleOnBusTap(String? busId) {
    navigationService.navigateTo(Routes.busDetailScreen,
        arguments: BusDetailScreenArguments(screenData: {
          "busId": busId,
          "sourceStop": _sourceStop!.id,
          "destinationStop": _destinationStop!.id,
        }));
  }

  handleExit() async {
    var exit = await dialogService.showDialog(
      title: "Exit",
      description: "Are you sure you want to exit?",
      cancelTitle: "Cancel",
      buttonTitle: "Yes",
    );
    if (exit!.confirmed) {
      SystemNavigator.pop();
    }
  }

  fabClick() async {
    dialogService.showCustomDialog(variant: DialogType.loading);
    pos = await locationService.getStaticLocation();
    navigationService.back();

    // mapController.move(LatLng(pos.latitude, pos.longitude), 16);
    if (_isShowingBottomSheet) {
      _selectedBusClientId = "";
      navigationService.back();
      _isShowingBottomSheet = false;
    }
    animatedMapMove(
      LatLng(pos.latitude, pos.longitude),
    );
    notifyListeners();
  }

  void animatedMapMove(LatLng destLocation) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final _latTween = Tween<double>(
        begin: _mapController!.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: _mapController!.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: 16, end: 16);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: _tickerProvider!);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      _mapController!.move(
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

  bool _isShowingBottomSheet = false;
  CarouselController _carouselController = CarouselController();
  handleMapTap() {
    if (_isShowingBottomSheet) {
      _selectedBusClientId = "";
      navigationService.back();
      _isShowingBottomSheet = false;
    }
    notifyListeners();
  }

  handleMarkerTap(dynamic element, BuildContext ctx, List streamData) async {
    if (_selectedBusClientId != element["client_id"]) {
      print(jsonEncode(element));
      print(jsonEncode(streamData));
      _selectedBusClientId = element["client_id"];
      animatedMapMove(LatLng(double.parse(element["data"]["latitude"]),
          double.parse(element["data"]["longitude"])));
      scaffoldKey!.currentState!.showBottomSheet((context) => Container(
            width: double.infinity,
            color: kTransparent,
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(vertical: kXXLSpace),
            child: CarouselSlider(
                carouselController: _carouselController,
                items: List<Widget>.generate(
                    streamData.length,
                    (index) => GestureDetector(
                          onTap: () {
                            navigationService.navigateTo(Routes.busDetailScreen,
                                arguments:
                                    BusDetailScreenArguments(screenData: {
                                  "busId": element["data"]["bus"]["_id"],
                                }));
                          },
                          child: Container(
                            color: kPrimaryColor,
                            margin:
                                EdgeInsets.symmetric(horizontal: kMediumSpace),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Container(
                                      height: double.infinity,
                                      padding:
                                          const EdgeInsets.all(kMediumSpace),
                                      decoration: BoxDecoration(
                                          color: kWhite.withOpacity(0.5),
                                          shape: BoxShape.circle),
                                      child: const Icon(
                                        Icons.directions_bus,
                                        size: kIconSize,
                                        color: kWhite,
                                      )),
                                  title: Text(
                                    streamData[index]["data"]["bus"]
                                        ["busNumber"],
                                    style: const TextStyle(color: kWhite),
                                  ),
                                  subtitle: Text(
                                    streamData[index]["data"]["bus"]["busType"],
                                    style: const TextStyle(color: kWhite),
                                  ),
                                  trailing: Chip(
                                    label: Text(
                                        streamData[index]["data"]["bus"]
                                            ["busProvider"],
                                        style: TextStyle(color: kBlack)),
                                    backgroundColor: kWhite.withOpacity(0.5),
                                  ),
                                ),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Container(
                                    child: StreamBuilder(
                                        stream: myStream,
                                        builder: (context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              Geolocator.distanceBetween(
                                                          double.parse(
                                                              streamData[index]
                                                                      ["data"]
                                                                  ["latitude"]),
                                                          double.parse(
                                                              streamData[index]
                                                                      ["data"][
                                                                  "longitude"]),
                                                          double.parse(snapshot
                                                              .data!["latitude"]
                                                              .toString()),
                                                          double.parse(snapshot
                                                              .data!["longitude"]
                                                              .toString()))
                                                      .round()
                                                      .toString() +
                                                  "m away from you",
                                              style: TextStyle(
                                                  color: kWhite,
                                                  fontSize: kLargeSpace),
                                            );
                                          } else {
                                            return Text("Calculating distance",
                                                style: TextStyle(
                                                    color: kWhite,
                                                    fontSize: kLargeSpace));
                                          }
                                        }),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                options: CarouselOptions(
                  initialPage: streamData.indexOf(element),
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: streamData.length > 1 ? true : false,
                  height: 120,
                  onPageChanged: (index, reason) {
                    _selectedBusClientId = streamData[index]["client_id"];
                    animatedMapMove(LatLng(
                        double.parse(streamData[index]["data"]["latitude"]),
                        double.parse(streamData[index]["data"]["longitude"])));
                  },
                )),
            /* child: Container(
              color: kPrimaryColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: () => handleOnBusTap(element["data"]["bus"]["_id"]),
                    leading: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.all(kMediumSpace),
                        decoration: BoxDecoration(
                            color: kWhite.withOpacity(0.5),
                            shape: BoxShape.circle),
                        child: const Icon(
                          Icons.directions_bus,
                          size: kIconSize,
                          color: kWhite,
                        )),
                    title: Text(
                      element["data"]["bus"]["busNumber"],
                      style: const TextStyle(color: kWhite),
                    ),
                    subtitle: Text(
                      element["data"]["bus"]["busType"],
                      style: const TextStyle(color: kWhite),
                    ),
                    trailing: Chip(
                      label: Text(element["data"]["bus"]["busProvider"],
                          style: TextStyle(color: kWhite)),
                      backgroundColor: kBlack.withOpacity(0.5),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        kLargeSpace, kMediumSpace, kLargeSpace, kLargeSpace),
                    child: Text(
                      Geolocator.distanceBetween(
                                  double.parse(element["data"]["latitude"]),
                                  double.parse(element["data"]["longitude"]),
                                  pos.latitude,
                                  pos.longitude)
                              .round()
                              .toString() +
                          "m away from you",
                      style: TextStyle(color: kWhite, fontSize: kLargeSpace),
                    ),
                  )
                ],
              ),
            ), */
          ));
      _isShowingBottomSheet = true;
    }
    notifyListeners();
  }

  addPassToBus(Map<String, dynamic> passData) async {
    print("called addPassToBus");
    streamSocket.addPassengerToBus(passData);
  }

  removePassFromBus(Map<String, dynamic> passData) async {
    print("called removePassFromBus");
    streamSocket.removePassengerFromBus(passData);
  }

  handleAboutTap() {
    navigationService.navigateTo(Routes.aboutView);
  }
}
