/// Excepción base de la aplicación
abstract class AppException implements Exception {
  const AppException({
    required this.message,
    this.code,
  });

  final String message;
  final String? code;

  @override
  String toString() => 'AppException: $message (code: $code)';
}

/// Excepción de red
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    this.statusCode,
  });

  final int? statusCode;

  @override
  String toString() =>
      'NetworkException: $message (status: $statusCode, code: $code)';
}

/// Excepción de caché
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code,
  });

  @override
  String toString() => 'CacheException: $message (code: $code)';
}

/// Excepción de autenticación
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.code,
  });

  @override
  String toString() => 'AuthException: $message (code: $code)';
}

/// Excepción de validación
class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.code,
    this.field,
  });

  final String? field;

  @override
  String toString() =>
      'ValidationException: $message (field: $field, code: $code)';
}

/// Excepción de servidor
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.code,
    this.statusCode,
  });

  final int? statusCode;

  @override
  String toString() =>
      'ServerException: $message (status: $statusCode, code: $code)';
}

/// Excepción de tiempo de espera
class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'La operación tardó demasiado tiempo',
    super.code = 'TIMEOUT',
  });

  @override
  String toString() => 'TimeoutException: $message';
}

/// Excepción de datos no encontrados
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Recurso no encontrado',
    super.code = 'NOT_FOUND',
  });

  @override
  String toString() => 'NotFoundException: $message';
}
