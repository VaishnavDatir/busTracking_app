import 'package:get_it/get_it.dart';

import '../core/services/navigator_service.dart';
import 'service_import.dart';
import 'services/auth_service.dart';
import 'services/bus_service.dart';
import 'services/dialog_service.dart';
import 'services/location_service.dart';
import 'services/sharedprefs_service.dart';
import 'services/user_service.dart';
import 'stream_socket.dart';

GetIt locator = GetIt.instance;

class LocatorInjector {
  static Future<void> setupLocator() async {
    var sharedPrefsInstance = await SharedPrefsService.getInstance();
    locator.registerSingleton<SharedPrefsService>(sharedPrefsInstance);
    locator.registerLazySingleton(() => NavigationService());
    locator.registerLazySingleton(() => DialogService());
    locator.registerLazySingleton(() => ServiceImport());
    locator.registerLazySingleton(() => AuthService());
    locator.registerLazySingleton(() => UserService());
    locator.registerLazySingleton(() => BusService());
    locator.registerLazySingleton(() => LocationService());

    //TRY
    locator.registerLazySingleton(() => StreamSocket());
  }
}
