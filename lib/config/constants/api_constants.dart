/// Constantes de configuración de la API de SpaceX
class ApiConstants {
  ApiConstants._();

  /// URL base de la API
  static const String baseUrl = 'https://api.spacexdata.com/v5';

  /// Endpoints
  static const String launches = '/launches';
  static const String rockets = '/rockets';
  static const String launchpads = '/launchpads';

  /// Timeouts en milisegundos
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  /// Reintentos
  static const int maxRetries = 3;
  static const int retryDelay = 1000;
}
