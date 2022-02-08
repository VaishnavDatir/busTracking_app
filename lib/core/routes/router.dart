import 'package:flutter/material.dart';

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
import '../../views/unknown_route_page.dart';
import 'router_path.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case kHomeScreen:
      return MaterialPageRoute(
        builder: (context) => HomeScreen(),
      );

    case kSigninScreen:
      return MaterialPageRoute(
        builder: (context) => SigninScreen(),
      );

    case kSignupScreen:
      return MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      );

/* <--------- Passenger Screens--------------> */

    case kPassengerHomeScreen:
      return MaterialPageRoute(
        builder: (context) => PassengerHomeScreen(),
      );

/* <----------- Driver Screens--------------> */

    case kDriverHomeScreen:
      return MaterialPageRoute(
        builder: (context) => DriverHomeScreen(),
      );

/* <------------- Stop Screen -----------> */
    case kStopSearchScreen:
      return MaterialPageRoute(
        builder: (context) => StopSearchScreen(),
      );

    case kStopListScreen:
      return MaterialPageRoute(
        builder: (context) => StopsListScreen(),
      );

    case kAddStopScreen:
      return MaterialPageRoute(
        builder: (context) => AddStopScreen(),
      );

/* <---------------- Bus Screen --------------> */
    case kBusDetailScreen:
      return MaterialPageRoute(
        builder: (context) =>
            BusDetailScreen(settings.arguments as Map<String, dynamic>?),
      );

    case kBusListScreen:
      return MaterialPageRoute(
        builder: (context) =>
            BusListScreen(settings.arguments as Map<String, dynamic>?),
      );

    case kAddBusScreen:
      return MaterialPageRoute(
        builder: (context) => CreateBusScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => UnknownRoutePage(),
      );
  }
}
