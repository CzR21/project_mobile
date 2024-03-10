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
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      //initialRoute: AppRoutes.home,
      navigatorObservers: [AppRoutes.myRouteObserver],
      routes: AppRoutes.routes,
      navigatorKey: AppRoutes.navigatorKey,
    );
  }
}