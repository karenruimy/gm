import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavRouter {
  /// Push
  static final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>();

  static Future push(
    BuildContext context,
    Widget route, {
    bool bottomToTop = false,
  }) {
    return Navigator.push(
        context,
        CupertinoPageRoute(
            fullscreenDialog: bottomToTop, builder: (_) => route));
  }

  /// Push Replacement
  static Future pushReplacement(
    BuildContext context,
    Widget route, {
    bool bottomToTop = false,
  }) {
    return Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            fullscreenDialog: bottomToTop, builder: (context) => route));
  }

  /// Pop
  static void pop(BuildContext context, [result]) {
    return Navigator.of(context).pop(result);
  }

  /// Push and remove until
  static Future pushAndRemoveUntil(BuildContext context, Widget route) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => route,
        ),
        (Route<dynamic> route) => false);
  }

  static Future openRouteFromDrawer(BuildContext context, Widget route) async {
    NavRouter.pop(context);
    NavRouter.push(context, route);
  }

  static Future<dynamic> to(Widget page, {arguments}) async =>
      navigationKey.currentState?.push(MaterialPageRoute(
        builder: (_) => page,
      ));

  static Future<dynamic> toAndRemoveUntil(Widget page, {arguments}) async =>
      navigationKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => page,
          ),
          (Route<dynamic> page) => false);
}
