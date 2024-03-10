import 'package:flutter/material.dart';
import 'package:project_mobile/pages/home_page.dart';
import 'package:project_mobile/pages/login/login_page.dart';

class AppRoutes{
  static RouteObserver myRouteObserver = RouteObserver();

  //Login
  static const String login = '/login';

  static const String home = '/home';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
    home: (context) => const HomePage(),
  };

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}