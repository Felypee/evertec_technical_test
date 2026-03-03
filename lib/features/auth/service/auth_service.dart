import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/constants/storage_keys.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/local_storage/secure_storage/secure_storage_service.dart';
import '../../../core/utils/validators.dart';
import '../models/user.dart';

/// Provider para el servicio de autenticación
final authServiceProvider = Provider<AuthService>((ref) {
  final secureStorage = ref.watch(secureStorageServiceProvider);
  return AuthService(secureStorage);
});

/// Servicio de autenticación local
class AuthService {
  AuthService(this._secureStorage);

  final SecureStorageService _secureStorage;

  /// Intenta iniciar sesión con las credenciales proporcionadas
  Future<User> login({
    required String username,
    required String password,
  }) async {
    try {
      // Validar nombre de usuario
      final usernameError = Validators.validateUsername(username);
      if (usernameError != null) {
        throw AuthException(message: usernameError);
      }

      // Validar contraseña
      if (!Validators.isPasswordValid(password)) {
        throw const AuthException(
          message: 'La contraseña no cumple con los requisitos de seguridad',
          code: 'INVALID_PASSWORD',
        );
      }

      // Verificar si el usuario existe
      final storedUsername = await _secureStorage.read(
        key: StorageKeys.username,
      );
      final storedPasswordHash = await _secureStorage.read(
        key: StorageKeys.passwordHash,
      );

      // Si no existe usuario, crear uno nuevo (primer login)
      if (storedUsername == null || storedPasswordHash == null) {
        return await _createUser(username, password);
      }

      // Verificar credenciales
      if (storedUsername != username) {
        throw const AuthException(
          message: 'Usuario no encontrado',
          code: 'USER_NOT_FOUND',
        );
      }

      final passwordHash = _hashPassword(password);
      if (storedPasswordHash != passwordHash) {
        throw const AuthException(
          message: 'Contraseña incorrecta',
          code: 'WRONG_PASSWORD',
        );
      }

      // Marcar como autenticado
      await _secureStorage.write(
        key: StorageKeys.isAuthenticated,
        value: 'true',
      );

      return User(
        username: username,
        lastLogin: DateTime.now(),
      );
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException(
        message: 'Error al iniciar sesión: ${e.toString()}',
        code: 'LOGIN_ERROR',
      );
    }
  }

  /// Crea un nuevo usuario (primer login)
  Future<User> _createUser(String username, String password) async {
    final passwordHash = _hashPassword(password);

    await _secureStorage.write(
      key: StorageKeys.username,
      value: username,
    );
    await _secureStorage.write(
      key: StorageKeys.passwordHash,
      value: passwordHash,
    );
    await _secureStorage.write(
      key: StorageKeys.isAuthenticated,
      value: 'true',
    );

    return User(
      username: username,
      lastLogin: DateTime.now(),
    );
  }

  /// Cierra la sesión del usuario
  Future<void> logout() async {
    try {
      await _secureStorage.write(
        key: StorageKeys.isAuthenticated,
        value: 'false',
      );
    } catch (e) {
      throw AuthException(
        message: 'Error al cerrar sesión: ${e.toString()}',
        code: 'LOGOUT_ERROR',
      );
    }
  }

  /// Verifica si hay una sesión activa
  Future<bool> isAuthenticated() async {
    try {
      final isAuth = await _secureStorage.read(
        key: StorageKeys.isAuthenticated,
      );
      return isAuth == 'true';
    } catch (e) {
      return false;
    }
  }

  /// Obtiene el usuario actual si está autenticado
  Future<User?> getCurrentUser() async {
    try {
      final isAuth = await isAuthenticated();
      if (!isAuth) return null;

      final username = await _secureStorage.read(key: StorageKeys.username);
      if (username == null) return null;

      return User(username: username);
    } catch (e) {
      return null;
    }
  }

  /// Genera un hash SHA256 de la contraseña
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
