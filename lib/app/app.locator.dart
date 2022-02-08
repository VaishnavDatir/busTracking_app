// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../core/services/auth_service.dart';
import '../core/services/bus_service.dart';
import '../core/services/location_service.dart';
import '../core/services/sharedprefs_service.dart';
import '../core/services/user_service.dart';
import '../core/stream_socket.dart';

final locator = StackedLocator.instance;

Future setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  final sharedPreferencesService = await SharedPreferencesService.getInstance();
  locator.registerSingleton(sharedPreferencesService);

  locator.registerLazySingleton<NavigationService>(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => BusService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => StreamSocket());
}
