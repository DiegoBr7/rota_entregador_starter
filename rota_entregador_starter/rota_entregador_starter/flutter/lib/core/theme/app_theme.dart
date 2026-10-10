import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      scaffoldBackgroundColor:
      const Color(0xFFF7FBFF),

      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0754B8),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF7FBFF),
        elevation: 0,
      ),
    );
  }
}