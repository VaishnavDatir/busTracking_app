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
    _userDetails = await userService.getUserData();
    if (_userDetails.success == false) {
      await dialogService.showDialog(
          description: _userDetails.message.toString() ??
              "There was an error while getting data.");
      handleLogout();
    }

    _isDriverOnBus = _userDetails.data.isActive;
    setBusy(false);
    notifyListeners();
  }

  changeIsDriverOnBus(bool value) {
    _isDriverOnBus = value;
    notifyListeners();
  }

  handleGoOnDuty() {
    // authService.logout();
  }

  handleLogout() {
    authService.logout();
  }
}
