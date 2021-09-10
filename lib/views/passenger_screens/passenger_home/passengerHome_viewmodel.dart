import 'package:BusTracking_App/core/models/stops_model.dart';
import 'package:BusTracking_App/core/models/userDetails_model.dart';
import 'package:BusTracking_App/core/routes/router_path.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/service_import.dart';

class PassengerViewModel extends BaseViewModel with ServiceImport {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController sourceTextController = TextEditingController();
  TextEditingController destinationTextController = TextEditingController();

  UserDetails _userDetails;
  UserDetails get userDetails => _userDetails;

  StopsData _sourceStop = StopsData(id: null, stopName: null, stopCity: null);
  StopsData get sourceStop => this._sourceStop;

  StopsData _destinationStop;
  StopsData get destinationStop => this._destinationStop;

  StopsData _selectedStop;

  void initializeScreen() async {
    setBusy(true);

    _userDetails = await userService.getUserData();

    if (_userDetails.success == false) {
      await dialogService.showDialog(
          description: _userDetails.message.toString() ??
              "There was an error while getting data.");
      handleLogout();
    }

    setBusy(false);
    notifyListeners();
  }

  void handleLogout() {
    authService.logout();
  }

  void handleSourceStopFieldTap({bool isDestination}) async {
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

  fabClick() {}

  void openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }
}
