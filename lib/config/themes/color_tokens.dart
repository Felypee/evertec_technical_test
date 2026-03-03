import 'package:flutter/material.dart';

/// Tokens de color inspirados en SpaceX
class ColorTokens {
  ColorTokens._();

  // Colores principales - Azul SpaceX
  static const Color spaceXBlue = Color(0xFF005288);
  static const Color spaceXBlueDark = Color(0xFF003357);
  static const Color spaceXBlueLight = Color(0xFF0073BA);

  // Colores secundarios - Espacio y cielo nocturno
  static const Color spaceBlack = Color(0xFF0A0A0A);
  static const Color cosmicGray = Color(0xFF1A1A2E);
  static const Color starWhite = Color(0xFFF5F5F5);

  // Colores de acento
  static const Color rocketOrange = Color(0xFFFF6B35);
  static const Color launchYellow = Color(0xFFFFD700);
  static const Color marsRed = Color(0xFFE94F37);

  // Colores de estado de lanzamientos
  static const Color statusSuccess = Color(0xFF55CC44);
  static const Color statusFailed = Color(0xFFD63D2E);
  static const Color statusUpcoming = Color(0xFF0073BA);

  // Alias para compatibilidad con código existente (temas)
  static const Color portalGreen = spaceXBlue;
  static const Color portalGreenDark = spaceXBlueDark;
  static const Color portalGreenLight = spaceXBlueLight;
  static const Color rickBlue = spaceXBlueLight;
  static const Color nebulaPurple = Color(0xFF5E35B1);
  static const Color cosmicBlue = cosmicGray;
  static const Color mortyYellow = launchYellow;
  static const Color statusAlive = statusSuccess;
  static const Color statusDead = statusFailed;
  static const Color statusUnknown = statusUpcoming;

  // Colores neutros para tema claro
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnSurface = Color(0xFF1C1C1C);
  static const Color lightOnSurfaceVariant = Color(0xFF5A5A5A);

  // Colores neutros para tema oscuro
  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkSurface = Color(0xFF1A1A2E);
  static const Color darkOnSurface = Color(0xFFE8E8E8);
  static const Color darkOnSurfaceVariant = Color(0xFFB0B0B0);

  // Colores de error
  static const Color error = Color(0xFFD63D2E);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onError = Color(0xFFFFFFFF);

  // Sombras y overlays
  static const Color shadowColor = Color(0x40000000);
  static const Color scrimColor = Color(0x80000000);
}
