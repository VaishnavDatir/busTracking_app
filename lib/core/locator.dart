import 'package:get_it/get_it.dart';

import '../core/services/navigator_service.dart';
import 'service_import.dart';
import 'services/auth_service.dart';
import 'services/dialog_service.dart';
import 'services/sharedprefs_service.dart';

GetIt locator = GetIt.instance;

class LocatorInjector {
  static Future<void> setupLocator() async {
    var sharedPrefsInstance = await SharedPrefsService.getInstance();
    locator.registerSingleton<SharedPrefsService>(sharedPrefsInstance);
    locator.registerLazySingleton(() => NavigationService());
    locator.registerLazySingleton(() => DialogService());
    locator.registerLazySingleton(() => ServiceImport());
    locator.registerLazySingleton(() => AuthService());
  }
}
