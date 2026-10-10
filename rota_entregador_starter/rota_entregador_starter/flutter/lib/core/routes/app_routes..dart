import 'package:flutter/cupertino.dart';
import 'package:rotas_app/features/onboarding/onboarding_page.dart';

import '../../features/onboarding/onboarding_page.dart';
import '../../features/auth/login_page.dart';
import '../../features/home/home_page.dart';
import '../../features/entregas/entregas_page.dart';
import '../../features/rotas/rotas_page.dart';
import '../../features/perfil/perfil_page.dart';

class AppRoutes {

  static const onboarding = '/';
  static const login = '/login';
  static const home = '/home';
  static const entregas = '/entregas';
  static const rotas = '/rotas';
  static const perfil = '/perfil';

  static final Map<String , WidgetBuilder> routes = {
    onboarding: (context) => const OnboardingPage(),
    login: (context) => const LoginPage(),
    home: (context) => const HomePage(),
    entregas: (context) => const EntregasPage(),
    rotas: (context) => const RotasPage(),
    perfil: (context) => const PerfilPage(),

  };


}

