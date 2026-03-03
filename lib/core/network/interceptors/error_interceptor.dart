import 'package:dio/dio.dart';
import '../../error/exceptions.dart';

/// Interceptor para manejar errores de manera consistente
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _mapDioException(err);

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: exception,
      ),
    );
  }

  /// Mapea excepciones de Dio a excepciones de la aplicación
  AppException _mapDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();

      case DioExceptionType.connectionError:
        if (error.error is NetworkException) {
          return error.error as NetworkException;
        }
        return const NetworkException(
          message: 'Error de conexión',
          code: 'CONNECTION_ERROR',
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);

      case DioExceptionType.cancel:
        return const NetworkException(
          message: 'Petición cancelada',
          code: 'CANCELLED',
        );

      case DioExceptionType.badCertificate:
        return const NetworkException(
          message: 'Certificado de seguridad inválido',
          code: 'BAD_CERTIFICATE',
        );

      case DioExceptionType.unknown:
        return NetworkException(
          message: error.message ?? 'Error desconocido',
          code: 'UNKNOWN',
        );
    }
  }

  /// Maneja respuestas con códigos de error HTTP
  AppException _handleBadResponse(Response<dynamic>? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;

    String message = 'Error del servidor';
    if (data is Map<String, dynamic> && data.containsKey('error')) {
      message = data['error'] as String;
    }

    switch (statusCode) {
      case 400:
        return ValidationException(
          message: message,
          code: 'BAD_REQUEST',
        );
      case 401:
        return const AuthException(
          message: 'No autorizado',
          code: 'UNAUTHORIZED',
        );
      case 403:
        return const AuthException(
          message: 'Acceso denegado',
          code: 'FORBIDDEN',
        );
      case 404:
        return const NotFoundException();
      case 500:
      case 502:
      case 503:
        return ServerException(
          message: 'Error del servidor',
          code: 'SERVER_ERROR',
          statusCode: statusCode,
        );
      default:
        return NetworkException(
          message: message,
          code: 'HTTP_$statusCode',
          statusCode: statusCode,
        );
    }
  }
}
