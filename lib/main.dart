import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/config/app_mock.dart';
import 'package:project_mobile/config/app_routes.dart';
import 'package:project_mobile/firebase_options.dart';
import 'package:project_mobile/repositories/autenticacao_repository.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AutenticacaoRepository.usuarioAutenticado.listen((User? user) => runApp(MyApp(initialRoute: user == null ? AppRoutes.login : AppRoutes.home,)));
}

class MyApp extends StatelessWidget {

  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

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
        initialRoute: initialRoute,
        navigatorObservers: [AppRoutes.myRouteObserver],
        routes: AppRoutes.routes,
        navigatorKey: AppRoutes.navigatorKey,
      ),
    );
  }
}