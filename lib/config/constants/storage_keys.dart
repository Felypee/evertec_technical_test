/// Claves de almacenamiento para la aplicación
class StorageKeys {
  StorageKeys._();

  /// Clave para el estado de autenticación
  static const String isAuthenticated = 'is_authenticated';

  /// Clave para el nombre de usuario
  static const String username = 'username';

  /// Clave para el hash de contraseña
  static const String passwordHash = 'password_hash';

  /// Clave para el tema seleccionado
  static const String themeMode = 'theme_mode';

  /// Clave para el idioma seleccionado
  static const String locale = 'locale';

  /// Clave para la última sincronización
  static const String lastSync = 'last_sync';
}
