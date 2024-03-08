import 'package:flutter/material.dart';
import 'package:project_mobile/pages/home_page.dart';

class AppRoutes{
  static RouteObserver myRouteObserver = RouteObserver();

  static const String home = '/home';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const HomePage(),
  };

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}