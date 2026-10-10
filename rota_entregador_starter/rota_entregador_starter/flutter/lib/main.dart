import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const RotasApp());

class RotasApp extends StatelessWidget {
  const RotasApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Minhas Rotas',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const HomeScreen());
}
