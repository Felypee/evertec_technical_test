import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:evertec_technical_test/core/network/network_info.dart';
import 'package:evertec_technical_test/core/local_storage/database/daos/launch_dao.dart';
import 'package:evertec_technical_test/core/local_storage/secure_storage/secure_storage_service.dart';

/// Mock de Dio para pruebas de red
class MockDio extends Mock implements Dio {}

/// Mock de NetworkInfo para pruebas de conectividad
class MockNetworkInfo extends Mock implements NetworkInfo {}

/// Mock de LaunchDao para pruebas de base de datos
class MockLaunchDao extends Mock implements LaunchDao {}

/// Mock de SecureStorageService para pruebas de almacenamiento
class MockSecureStorageService extends Mock implements SecureStorageService {}

/// Configuración de fallback values para mocks
void setupMockFallbackValues() {
  registerFallbackValue(RequestOptions(path: ''));
}
