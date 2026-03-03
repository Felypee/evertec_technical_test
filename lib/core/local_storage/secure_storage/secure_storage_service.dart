import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Provider para el servicio de almacenamiento seguro
final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

/// Servicio para almacenamiento seguro de datos sensibles
class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  /// Guarda un valor de forma segura
  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  /// Lee un valor guardado
  Future<String?> read({required String key}) async {
    return await _storage.read(key: key);
  }

  /// Elimina un valor guardado
  Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  /// Elimina todos los valores guardados
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /// Verifica si existe una clave
  Future<bool> containsKey({required String key}) async {
    return await _storage.containsKey(key: key);
  }

  /// Obtiene todas las claves guardadas
  Future<Map<String, String>> readAll() async {
    return await _storage.readAll();
  }
}
