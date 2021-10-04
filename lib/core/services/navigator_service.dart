import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  pop({dynamic arguments}) {
    return _navigationKey.currentState.pop(arguments);
  }

  popWithContext(BuildContext ctx) {
    // return _navigationKey.currentState.pop(ctx);
    /*    return _navigationKey.currentState
        .pop(_navigationKey.currentState.overlay.context); */

    return Navigator.of(ctx).pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> replaceAndNavigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> popEverythingAndNavigateTo(String routeName,
      {dynamic arguments}) {
    return _navigationKey.currentState.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  Future<dynamic> popTillAndNavigateTo(String routeName, {dynamic arguments}) {
    int count = 0;
    return _navigationKey.currentState.pushNamedAndRemoveUntil(
        routeName, (_) => count++ >= 2,
        arguments: arguments);
  }
}
