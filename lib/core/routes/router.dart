import 'package:BusTracking_App/views/add_stop/add_stop_screen.dart';
import 'package:BusTracking_App/views/bus_list/busList_screen.dart';
import 'package:BusTracking_App/views/stop_list/stopList_screen.dart';
import 'package:flutter/material.dart';

import '../../views/bus_detail/bus_detail_screenn.dart';
import '../../views/driver_screens/driver_home/driverHome_screen.dart';
import '../../views/home/homescreen.dart';
import '../../views/passenger_screens/passenger_home/passengerHome_screen.dart';
import '../../views/signin/signin_screen.dart';
import '../../views/signup/signup_screen.dart';
import '../../views/stop_search/stopSearchScreen.dart';
import '../../views/unknown_route_page.dart';
import 'router_path.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case kHomeScreen:
      return MaterialPageRoute(
        builder: (context) => HomeScreen(),
      );
      break;

    case kSigninScreen:
      return MaterialPageRoute(
        builder: (context) => SigninScreen(),
      );
      break;

    case kSignupScreen:
      return MaterialPageRoute(
        builder: (context) => SignUpScreen(),
      );
      break;

/* <--------- Passenger Screens--------------> */

    case kPassengerHomeScreen:
      return MaterialPageRoute(
        builder: (context) => PassengerHomeScreen(),
      );
      break;

/* <----------- Driver Screens--------------> */

    case kDriverHomeScreen:
      return MaterialPageRoute(
        builder: (context) => DriverHomeScreen(),
      );
      break;

/* <------------- Stop Screen -----------> */
    case kStopSearchScreen:
      return MaterialPageRoute(
        builder: (context) => StopSearchScreen(),
      );
      break;

    case kStopListScreen:
      return MaterialPageRoute(
        builder: (context) => StopsListScreen(),
      );
      break;

    case kAddStopScreen:
      return MaterialPageRoute(
        builder: (context) => AddStopScreen(),
      );
      break;

/* <---------------- Bus Screen --------------> */
    case kBusDetailScreen:
      return MaterialPageRoute(
        builder: (context) => BusDetailScreen(settings.arguments),
      );
      break;

    case kBusListScreen:
      return MaterialPageRoute(
        builder: (context) => BusListScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => UnknownRoutePage(),
      );
      break;
  }
}
