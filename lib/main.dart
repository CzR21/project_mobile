import 'package:flutter/material.dart';
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
      theme: ThemeData(
        canvasColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      initialRoute: AppRoutes.home,//AppRoutes.login,
      navigatorObservers: [AppRoutes.myRouteObserver],
      routes: AppRoutes.routes,
      navigatorKey: AppRoutes.navigatorKey,
    );
  }
}