import 'package:flutter/material.dart';
import 'package:project_mobile/pages/home_page.dart';
import 'package:project_mobile/settings/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food APP',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      navigatorObservers: [AppRoutes.myRouteObserver],
      routes: AppRoutes.routes,
      navigatorKey: AppRoutes.navigatorKey,
    );
  }
}