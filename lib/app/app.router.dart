// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../views/add_bus/addBus_screen.dart';
import '../views/add_stop/add_stop_screen.dart';
import '../views/bus_detail/bus_detail_screenn.dart';
import '../views/bus_list/busList_screen.dart';
import '../views/driver_screens/driver_home/driverHome_screen.dart';
import '../views/home/homescreen.dart';
import '../views/passenger_screens/passenger_home/passengerHome_screen.dart';
import '../views/signin/signin_screen.dart';
import '../views/signup/signup_screen.dart';
import '../views/stop_list/stopList_screen.dart';
import '../views/stop_search/stopSearchScreen.dart';

class Routes {
  static const String homeScreen = '/';
  static const String signinScreen = '/signin-screen';
  static const String signUpScreen = '/sign-up-screen';
  static const String passengerHomeScreen = '/passenger-home-screen';
  static const String driverHomeScreen = '/driver-home-screen';
  static const String stopSearchScreen = '/stop-search-screen';
  static const String stopsListScreen = '/stops-list-screen';
  static const String addStopScreen = '/add-stop-screen';
  static const String busDetailScreen = '/bus-detail-screen';
  static const String busListScreen = '/bus-list-screen';
  static const String createBusScreen = '/create-bus-screen';
  static const all = <String>{
    homeScreen,
    signinScreen,
    signUpScreen,
    passengerHomeScreen,
    driverHomeScreen,
    stopSearchScreen,
    stopsListScreen,
    addStopScreen,
    busDetailScreen,
    busListScreen,
    createBusScreen,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeScreen, page: HomeScreen),
    RouteDef(Routes.signinScreen, page: SigninScreen),
    RouteDef(Routes.signUpScreen, page: SignUpScreen),
    RouteDef(Routes.passengerHomeScreen, page: PassengerHomeScreen),
    RouteDef(Routes.driverHomeScreen, page: DriverHomeScreen),
    RouteDef(Routes.stopSearchScreen, page: StopSearchScreen),
    RouteDef(Routes.stopsListScreen, page: StopsListScreen),
    RouteDef(Routes.addStopScreen, page: AddStopScreen),
    RouteDef(Routes.busDetailScreen, page: BusDetailScreen),
    RouteDef(Routes.busListScreen, page: BusListScreen),
    RouteDef(Routes.createBusScreen, page: CreateBusScreen),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    HomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeScreen(),
        settings: data,
      );
    },
    SigninScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SigninScreen(),
        settings: data,
      );
    },
    SignUpScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUpScreen(),
        settings: data,
      );
    },
    PassengerHomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PassengerHomeScreen(),
        settings: data,
      );
    },
    DriverHomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => DriverHomeScreen(),
        settings: data,
      );
    },
    StopSearchScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StopSearchScreen(),
        settings: data,
      );
    },
    StopsListScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StopsListScreen(),
        settings: data,
      );
    },
    AddStopScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddStopScreen(),
        settings: data,
      );
    },
    BusDetailScreen: (data) {
      var args = data.getArgs<BusDetailScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => BusDetailScreen(args.screenData),
        settings: data,
      );
    },
    BusListScreen: (data) {
      var args = data.getArgs<BusListScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => BusListScreen(args.screenData),
        settings: data,
      );
    },
    CreateBusScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreateBusScreen(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// BusDetailScreen arguments holder class
class BusDetailScreenArguments {
  final Map<String, dynamic>? screenData;
  BusDetailScreenArguments({required this.screenData});
}

/// BusListScreen arguments holder class
class BusListScreenArguments {
  final Map<String, dynamic>? screenData;
  BusListScreenArguments({required this.screenData});
}
