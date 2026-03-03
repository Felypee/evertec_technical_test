import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/constants/api_constants.dart';
import 'interceptors/connectivity_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/retry_interceptor.dart';
import 'network_info.dart';

/// Provider para el cliente HTTP Dio
final dioClientProvider = Provider<Dio>((ref) {
  final networkInfo = ref.watch(networkInfoProvider);
  return DioClient.create(networkInfo);
});

/// Cliente HTTP configurado con interceptores
class DioClient {
  DioClient._();

  /// Crea una instancia de Dio configurada
  static Dio create(NetworkInfo networkInfo) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(
          milliseconds: ApiConstants.connectTimeout,
        ),
        receiveTimeout: const Duration(
          milliseconds: ApiConstants.receiveTimeout,
        ),
        sendTimeout: const Duration(
          milliseconds: ApiConstants.sendTimeout,
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Agregar interceptores en orden
    dio.interceptors.addAll([
      ConnectivityInterceptor(networkInfo),
      ErrorInterceptor(),
      RetryInterceptor(dio),
      // Log interceptor solo en modo debug
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) {
          // Usar assert para que solo funcione en debug
          assert(() {
            // ignore: avoid_print
            print(object);
            return true;
          }());
        },
      ),
    ]);

    return dio;
  }
}
