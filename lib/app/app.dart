import '../views/home/homescreen.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../views/add_bus/addBus_screen.dart';
import '../../views/add_stop/add_stop_screen.dart';
import '../../views/bus_detail/bus_detail_screenn.dart';
import '../../views/bus_list/busList_screen.dart';
import '../../views/driver_screens/driver_home/driverHome_screen.dart';
import '../../views/home/homescreen.dart';
import '../../views/passenger_screens/passenger_home/passengerHome_screen.dart';
import '../../views/signin/signin_screen.dart';
import '../../views/signup/signup_screen.dart';
import '../../views/stop_list/stopList_screen.dart';
import '../../views/stop_search/stopSearchScreen.dart';
import '../core/services/auth_service.dart';
import '../core/services/bus_service.dart';
import '../core/services/location_service.dart';
import '../core/services/sharedprefs_service.dart';
import '../core/services/user_service.dart';
import '../core/stream_socket.dart';

@StackedApp(routes: [
  MaterialRoute(page: HomeScreen, initial: true),
  MaterialRoute(page: SigninScreen),
  MaterialRoute(page: SignUpScreen),

/* <--------- Passenger Screens--------------> */

  MaterialRoute(page: PassengerHomeScreen),

/* <----------- Driver Screens--------------> */

  MaterialRoute(page: DriverHomeScreen),

/* <------------- Stop Screen -----------> */

  MaterialRoute(page: StopSearchScreen),
  MaterialRoute(page: StopsListScreen),
  MaterialRoute(page: AddStopScreen),

/* <------------ Bus Screen ------------- */

  MaterialRoute(page: BusDetailScreen),
  MaterialRoute(page: BusListScreen),
  MaterialRoute(page: CreateBusScreen),
], dependencies: [
  Presolve(
    classType: SharedPreferencesService,
    presolveUsing: SharedPreferencesService.getInstance,
  ),
  LazySingleton(classType: NavigationService, asType: NavigationService),
  LazySingleton(classType: DialogService),
  LazySingleton(classType: SnackbarService),
  LazySingleton(classType: AuthService),
  LazySingleton(classType: UserService),
  LazySingleton(classType: BusService),
  LazySingleton(classType: LocationService),
  LazySingleton(classType: StreamSocket),
])
class App {}
