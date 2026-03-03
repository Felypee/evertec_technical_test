import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/storage_keys.dart';

/// Provider para el modo de tema actual
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
  (ref) => ThemeModeNotifier(),
);

/// Notifier para manejar cambios de tema con persistencia
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  final _storage = const FlutterSecureStorage();

  /// Carga el tema guardado en almacenamiento
  Future<void> _loadTheme() async {
    try {
      final savedTheme = await _storage.read(key: StorageKeys.themeMode);
      if (savedTheme != null) {
        state = ThemeMode.values.firstWhere(
          (mode) => mode.name == savedTheme,
          orElse: () => ThemeMode.system,
        );
      }
    } catch (e) {
      // En caso de error, mantener tema del sistema
      state = ThemeMode.system;
    }
  }

  /// Cambia el tema y lo persiste
  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    try {
      await _storage.write(key: StorageKeys.themeMode, value: mode.name);
    } catch (e) {
      // Error silencioso en persistencia
    }
  }

  /// Alterna entre tema claro y oscuro
  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setTheme(newMode);
  }

  /// Verifica si el tema actual es oscuro
  bool isDarkMode(BuildContext context) {
    if (state == ThemeMode.system) {
      return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    }
    return state == ThemeMode.dark;
  }
}
