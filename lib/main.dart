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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppMock(),
      builder: (context, child) => StreamBuilder(
        stream: AutenticacaoRepository.usuarioAutenticado,
        builder: (context, snapshot) => MaterialApp(
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
          initialRoute: snapshot.hasData ? AppRoutes.home : AppRoutes.login,
          navigatorObservers: [AppRoutes.myRouteObserver],
          routes: AppRoutes.routes,
          navigatorKey: AppRoutes.navigatorKey,
        )
      ),
    );
  }
}