import '../../../core/models/dialog_model.dart';
import '../../../core/routes/router_path.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import '../../../core/models/userDetails_model.dart';
import '../../../core/service_import.dart';

class DriverHomeViewModel extends BaseViewModel with ServiceImport {
  UserDetails _userDetails;
  UserDetails get userDetails => _userDetails;

  bool _isDriverOnBus;
  bool get isDriverOnBus => _isDriverOnBus;

  initializeScreen() async {
    setBusy(true);
    _userDetails = userService.userDetails;

    _isDriverOnBus = _userDetails.data.isActive;
    setBusy(false);
    notifyListeners();
  }

  changeIsDriverOnBus(bool value) {
    _isDriverOnBus = value;
    notifyListeners();
  }

  showBusList() {
    navigationService.navigateTo(kBusListScreen);
  }

  showStopList() {
    navigationService.navigateTo(kStopListScreen);
  }

  handleGoOnDuty() {}

  handleLogout() {
    authService.logout();
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
