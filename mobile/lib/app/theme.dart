import 'package:flutter/material.dart';

class LuminaryTheme {
  // Core palette
  static const indigo = Color(0xFF1D2746);
  static const indigoDeep = Color(0xFF141C35);

  static const terracotta = Color(0xFFC85B3C);
  static const terracottaSoft = Color(0xFFE9B09B);

  static const ivory = Color(0xFFF9F6F0);
  static const paper = Color(0xFFFFFCF7);

  static const green = Color(0xFF28735D);
  static const greenSoft = Color(0xFFDCECE5);

  static const charcoal = Color(0xFF25231F);
  static const muted = Color(0xFF716B63);
  static const line = Color(0xFFE4DDD4);

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: indigo,
      brightness: Brightness.light,
    ).copyWith(
      primary: indigo,
      onPrimary: Colors.white,
      secondary: terracotta,
      onSecondary: Colors.white,
      surface: paper,
      onSurface: charcoal,
      outline: line,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,

      scaffoldBackgroundColor: ivory,

      splashFactory: InkSparkle.splashFactory,

      appBarTheme: const AppBarTheme(
        backgroundColor: ivory,
        foregroundColor: charcoal,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleSpacing: 20,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
          color: charcoal,
        ),
        iconTheme: IconThemeData(
          color: charcoal,
          size: 23,
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        backgroundColor: paper,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        indicatorColor: const Color(0xFFE9ECF4),
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: charcoal,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) {
            return IconThemeData(
              size: 22,
              color: states.contains(WidgetState.selected)
                  ? indigo
                  : muted,
            );
          },
        ),
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 44,
          height: 1.02,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.8,
          color: charcoal,
        ),

        displayMedium: TextStyle(
          fontSize: 38,
          height: 1.04,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.4,
          color: charcoal,
        ),

        displaySmall: TextStyle(
          fontSize: 32,
          height: 1.06,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.1,
          color: charcoal,
        ),

        headlineLarge: TextStyle(
          fontSize: 30,
          height: 1.08,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.9,
          color: charcoal,
        ),

        headlineMedium: TextStyle(
          fontSize: 27,
          height: 1.1,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.7,
          color: charcoal,
        ),

        headlineSmall: TextStyle(
          fontSize: 24,
          height: 1.12,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
          color: charcoal,
        ),

        titleLarge: TextStyle(
          fontSize: 19,
          height: 1.2,
          fontWeight: FontWeight.w700,
          color: charcoal,
        ),

        titleMedium: TextStyle(
          fontSize: 16,
          height: 1.25,
          fontWeight: FontWeight.w600,
          color: charcoal,
        ),

        titleSmall: TextStyle(
          fontSize: 14,
          height: 1.25,
          fontWeight: FontWeight.w700,
          color: charcoal,
        ),

        bodyLarge: TextStyle(
          fontSize: 16,
          height: 1.5,
          color: charcoal,
        ),

        bodyMedium: TextStyle(
          fontSize: 14,
          height: 1.45,
          color: muted,
        ),

        bodySmall: TextStyle(
          fontSize: 12,
          height: 1.4,
          color: muted,
        ),

        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.1,
        ),

        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),

      cardTheme: const CardThemeData(
        elevation: 0,
        color: paper,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          side: BorderSide(
            color: line,
            width: 1,
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: indigo,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size.fromHeight(54),
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: indigo,
          backgroundColor: Colors.transparent,
          minimumSize: const Size.fromHeight(52),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          side: const BorderSide(
            color: line,
            width: 1.2,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: indigo,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
      ),

      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: paper,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 16,
        ),
        hintStyle: TextStyle(
          color: muted,
          fontSize: 14,
        ),
        labelStyle: TextStyle(
          color: muted,
          fontSize: 14,
        ),
        floatingLabelStyle: TextStyle(
          color: indigo,
          fontWeight: FontWeight.w600,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          borderSide: BorderSide(
            color: line,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          borderSide: BorderSide(
            color: line,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          borderSide: BorderSide(
            color: indigo,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          borderSide: BorderSide(
            color: terracotta,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          borderSide: BorderSide(
            color: terracotta,
            width: 1.5,
          ),
        ),
      ),

      chipTheme: const ChipThemeData(
        backgroundColor: paper,
        selectedColor: indigo,
        disabledColor: Color(0xFFEFEAE3),
        side: BorderSide(
          color: line,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        labelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: charcoal,
        ),
        secondaryLabelStyle: TextStyle(
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 7,
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: line,
        thickness: 1,
        space: 1,
      ),

      snackBarTheme: const SnackBarThemeData(
        backgroundColor: indigoDeep,
        contentTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: indigo,
        linearTrackColor: line,
      ),
    );
  }
}