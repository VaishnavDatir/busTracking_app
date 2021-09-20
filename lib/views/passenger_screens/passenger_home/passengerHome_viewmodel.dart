import 'package:BusTracking_App/core/models/dialog_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import '../../../core/models/bus_model.dart';
import '../../../core/models/stops_model.dart';
import '../../../core/models/userDetails_model.dart';
import '../../../core/routes/router_path.dart';
import '../../../core/service_import.dart';

class PassengerViewModel extends BaseViewModel with ServiceImport {
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

  void initializeScreen() async {
    setBusy(true);

    _userDetails = userService.userDetails;

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

  fabClick() {}

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
}
