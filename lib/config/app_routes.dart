import 'package:flutter/material.dart';
import 'package:project_mobile/data/models/restaurante_model.dart';
import 'package:project_mobile/pages/home/home_page.dart';
import 'package:project_mobile/pages/login/cadastro_page.dart';
import 'package:project_mobile/pages/login/esqueci_senha_page.dart';
import 'package:project_mobile/pages/login/login_page.dart';
import 'package:project_mobile/pages/restaurante/restaurante_page.dart';

class AppRoutes {
  static RouteObserver myRouteObserver = RouteObserver();

  //Login
  static const String login = '/login';
  static const String cadastro = '/cadastro';
  static const String esqueciSenha = '/esqueciSenha';

  static const String home = '/home';

  static const String restaurante = '/restaurante';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginPage(),
    cadastro: (context) => const CadastroPage(),
    esqueciSenha: (context) => const EsqueciSenhaPage(),
    home: (context) => const HomePage(),
    restaurante: (context) {
      final restauranteArg = ModalRoute.of(context)!.settings.arguments as RestauranteModel;

      return RestaurantePage(restaurante: restauranteArg);
    }
  };

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
