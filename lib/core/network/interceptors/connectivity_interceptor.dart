import 'package:dio/dio.dart';
import '../../error/exceptions.dart';
import '../network_info.dart';

/// Interceptor que verifica la conectividad antes de hacer peticiones
class ConnectivityInterceptor extends Interceptor {
  ConnectivityInterceptor(this._networkInfo);

  final NetworkInfo _networkInfo;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isConnected = await _networkInfo.isConnected;

    if (!isConnected) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: const NetworkException(
            message: 'Sin conexión a internet',
            code: 'NO_CONNECTION',
          ),
        ),
      );
      return;
    }

    handler.next(options);
  }
}
