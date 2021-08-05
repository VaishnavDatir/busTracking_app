import 'package:BusTracking_App/views/home/homescreen.dart';
import 'package:flutter/material.dart';

import '../../views/unknown_route_page.dart';
import 'router_path.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case kHomeScreen:
      return MaterialPageRoute(builder: (context) => HomeScreen());
      break;

    default:
      return MaterialPageRoute(builder: (context) => UnknownRoutePage());
      break;
  }
}
