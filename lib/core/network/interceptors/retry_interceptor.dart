import 'dart:async';
import 'package:dio/dio.dart';
import '../../../config/constants/api_constants.dart';

/// Interceptor para reintentar peticiones fallidas
class RetryInterceptor extends Interceptor {
  RetryInterceptor(this._dio);

  final Dio _dio;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Solo reintentar en errores de conexión o timeout
    if (!_shouldRetry(err)) {
      handler.next(err);
      return;
    }

    // Obtener número de reintentos actuales
    final dynamic retryCountDynamic = err.requestOptions.extra['retryCount'] ?? 0;
    final int retryCount = retryCountDynamic is int ? retryCountDynamic : 0;

    if (retryCount >= ApiConstants.maxRetries) {
      handler.next(err);
      return;
    }

    // Esperar antes de reintentar (backoff exponencial)
    final delay = Duration(
      milliseconds: ApiConstants.retryDelay * (retryCount + 1),
    );
    await Future.delayed(delay);

    // Actualizar contador de reintentos
    final options = err.requestOptions;
    options.extra['retryCount'] = retryCount + 1;

    try {
      final response = await _dio.fetch(options);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  /// Determina si el error es elegible para reintento
  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError ||
        (error.type == DioExceptionType.badResponse &&
            error.response?.statusCode != null &&
            error.response!.statusCode! >= 500);
  }
}
