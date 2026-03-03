import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'color_tokens.dart';

/// Configuración de temas de la aplicación (Material 3)
class AppTheme {
  AppTheme._();

  /// Tema claro
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: ColorTokens.portalGreen,
        onPrimary: Colors.white,
        primaryContainer: ColorTokens.portalGreenLight,
        onPrimaryContainer: ColorTokens.portalGreenDark,
        secondary: ColorTokens.rickBlue,
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFFB3E5FC),
        onSecondaryContainer: Color(0xFF004D61),
        tertiary: ColorTokens.nebulaPurple,
        onTertiary: Colors.white,
        error: ColorTokens.error,
        onError: ColorTokens.onError,
        errorContainer: ColorTokens.errorContainer,
        surface: ColorTokens.lightSurface,
        onSurface: ColorTokens.lightOnSurface,
        onSurfaceVariant: ColorTokens.lightOnSurfaceVariant,
      ),
      scaffoldBackgroundColor: ColorTokens.lightBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorTokens.lightSurface,
        foregroundColor: ColorTokens.lightOnSurface,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      cardTheme: CardThemeData(
        color: ColorTokens.lightSurface,
        elevation: 2,
        shadowColor: ColorTokens.shadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorTokens.portalGreen,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorTokens.portalGreen,
          side: const BorderSide(color: ColorTokens.portalGreen),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorTokens.portalGreen,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorTokens.lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorTokens.lightOnSurfaceVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorTokens.portalGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorTokens.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: ColorTokens.lightSurface,
        selectedColor: ColorTokens.portalGreen.withValues(alpha: 0.2),
        labelStyle: const TextStyle(fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ColorTokens.lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: ColorTokens.lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ColorTokens.cosmicBlue,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Tema oscuro
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: ColorTokens.portalGreen,
        onPrimary: Colors.black,
        primaryContainer: ColorTokens.portalGreenDark,
        onPrimaryContainer: ColorTokens.portalGreenLight,
        secondary: ColorTokens.rickBlue,
        onSecondary: Colors.black,
        secondaryContainer: Color(0xFF004D61),
        onSecondaryContainer: Color(0xFFB3E5FC),
        tertiary: ColorTokens.nebulaPurple,
        onTertiary: Colors.white,
        error: ColorTokens.error,
        onError: ColorTokens.onError,
        surface: ColorTokens.darkSurface,
        onSurface: ColorTokens.darkOnSurface,
        onSurfaceVariant: ColorTokens.darkOnSurfaceVariant,
      ),
      scaffoldBackgroundColor: ColorTokens.darkBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorTokens.darkSurface,
        foregroundColor: ColorTokens.darkOnSurface,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      cardTheme: CardThemeData(
        color: ColorTokens.darkSurface,
        elevation: 4,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorTokens.portalGreen,
          foregroundColor: Colors.black,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorTokens.portalGreen,
          side: const BorderSide(color: ColorTokens.portalGreen),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorTokens.portalGreen,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorTokens.darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorTokens.darkOnSurfaceVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorTokens.portalGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorTokens.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: ColorTokens.darkSurface,
        selectedColor: ColorTokens.portalGreen.withValues(alpha: 0.3),
        labelStyle: const TextStyle(fontSize: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ColorTokens.darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: ColorTokens.darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ColorTokens.portalGreen,
        contentTextStyle: const TextStyle(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
