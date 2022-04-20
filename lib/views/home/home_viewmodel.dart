import 'package:stacked/stacked.dart';

import '../../app/app.router.dart';
import '../../core/constants.dart';
import '../../core/service_import.dart';

class HomeViewModel extends BaseViewModel with ServiceImport {
  initializeScreen() async {
    // await Future.delayed(Duration(seconds: 5));
    bool isSignedIn =
        await sharedPrefsService.read(Constants.sharedPrefsIsSignedIn) ?? false;
    if (isSignedIn) {
      await authService.getUserToken();
      await userService.getUserData();

      if (userService.userDetails!.success!) {
        busService.getAllStops();
        busService.getAllBusList();
        streamSocket.socketConnect();
        await Future.delayed(Duration(seconds: 1));
        bool isDriver =
            await sharedPrefsService.read(Constants.sharedPrefsUserType);

        if (isDriver) {
          navigationService.clearStackAndShow(Routes.driverHomeScreen);
        } else {
          navigationService.clearStackAndShow(Routes.passengerHomeScreen);
        }
      } else {
        sharedPrefsService.clear();
        navigationService.clearStackAndShow(Routes.signinScreen);
      }
    } else {
      // navigationService!.popEverythingAndNavigateTo(kSigninScreen);
      navigationService.clearStackAndShow(Routes.signinScreen);
    }
  }
}
