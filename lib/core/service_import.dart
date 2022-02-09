import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import 'services/auth_service.dart';
import 'services/bus_service.dart';
import 'services/location_service.dart';
import 'services/sharedprefs_service.dart';
import 'services/user_service.dart';
import 'stream_socket.dart';

class ServiceImport {
  NavigationService get navigationService => locator<NavigationService>();
  DialogService get dialogService => locator<DialogService>();
  SnackbarService get snackbarService => locator<SnackbarService>();
  SharedPreferencesService get sharedPrefsService =>
      locator<SharedPreferencesService>();
  AuthService get authService => locator<AuthService>();
  UserService get userService => locator<UserService>();
  BusService get busService => locator<BusService>();
  LocationService get locationService => locator<LocationService>();
  StreamSocket get streamSocket => locator<StreamSocket>();
}
