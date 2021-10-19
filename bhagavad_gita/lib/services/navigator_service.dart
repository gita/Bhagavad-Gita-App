import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> pushNamed(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (r) => false, arguments: arguments);
  }

  Future<dynamic> pushAndRemoveUntil({required Widget viewToShow}) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => viewToShow),
        (Route<dynamic> route) => false);
  }

  Future<dynamic> pushReplacement({required Widget viewToShow}) {
    return navigatorKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (_) => viewToShow));
  }

  Future<dynamic> pushReplacementNamed(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  goBack() {
    return navigatorKey.currentState!.pop(true);
  }
}
