import 'package:flutter/material.dart';
import 'package:project_mobile/config/app_mock.dart';
import 'package:project_mobile/config/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppMock(),
      builder: (context, child) => MaterialApp(
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
        initialRoute: AppRoutes.login,
        navigatorObservers: [AppRoutes.myRouteObserver],
        routes: AppRoutes.routes,
        navigatorKey: AppRoutes.navigatorKey,
      ),
    );
  }
}