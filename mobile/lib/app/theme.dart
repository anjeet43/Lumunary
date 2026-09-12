import 'package:flutter/material.dart';

class LuminaryTheme {
  static const indigo = Color(0xFF202B4D);
  static const terracotta = Color(0xFFC85B3C);
  static const ivory = Color(0xFFFFFCF7);
  static const green = Color(0xFF27705A);
  static const charcoal = Color(0xFF24221F);
  static ThemeData get light => ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
          seedColor: indigo, brightness: Brightness.light, surface: ivory),
      scaffoldBackgroundColor: ivory,
      textTheme: const TextTheme(
          displaySmall: TextStyle(
              fontSize: 34,
              height: 1.06,
              fontWeight: FontWeight.w700,
              letterSpacing: -1.1,
              color: charcoal),
          headlineSmall: TextStyle(
              fontSize: 26,
              height: 1.14,
              fontWeight: FontWeight.w700,
              letterSpacing: -.6,
              color: charcoal),
          titleLarge: TextStyle(
              fontSize: 19,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: charcoal),
          titleMedium: TextStyle(
              fontSize: 16,
              height: 1.25,
              fontWeight: FontWeight.w600,
              color: charcoal),
          bodyLarge: TextStyle(fontSize: 16, height: 1.45, color: charcoal),
          bodyMedium:
              TextStyle(fontSize: 14, height: 1.42, color: Color(0xFF686158)),
          labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
      cardTheme: const CardThemeData(
          elevation: 0,
          color: Colors.white,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              side: BorderSide(color: Color(0xFFE8E0D7)))),
      filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
              backgroundColor: indigo,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(54),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14))))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              foregroundColor: indigo,
              side: const BorderSide(color: Color(0xFFD8D0C6)),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14))))),
      inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
              borderSide: BorderSide(color: Color(0xFFD8D0C6))),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14)));
}
