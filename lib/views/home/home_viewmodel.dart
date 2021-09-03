import 'package:stacked/stacked.dart';

import '../../core/constants.dart';
import '../../core/routes/router_path.dart';
import '../../core/service_import.dart';

class HomeViewModel extends BaseViewModel with ServiceImport {
  initializeScreen() async {
    await Future.delayed(Duration(seconds: 3));
    bool isSignedIn =
        await sharedPrefsService.read(Constants.sharedPrefsIsSignedIn) ?? false;
    if (isSignedIn) {
      bool isDriver =
          await sharedPrefsService.read(Constants.sharedPrefsUserType);
      if (isDriver) {
        navigationService.popEverythingAndNavigateTo(kDriverHomeScreen);
      } else {
        navigationService.popEverythingAndNavigateTo(kPassengerHomeScreen);
      }
    } else {
      navigationService.popEverythingAndNavigateTo(kSigninScreen);
    }
  }
}
