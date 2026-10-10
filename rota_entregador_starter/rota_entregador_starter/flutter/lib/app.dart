import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'core/routes/app_routes..dart';
import 'core/theme/app_theme.dart';

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rotas Inteligentes',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.onboarding,
        routes:AppRoutes.routes,

    );
  }
}
