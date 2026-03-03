import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/constants/api_constants.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/local_storage/database/app_database.dart';
import '../../../core/local_storage/database/daos/launch_dao.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_info.dart';
import '../../home/models/launch.dart';

/// Provider para el servicio de detalle de lanzamiento
final launchDetailServiceProvider = Provider<LaunchDetailService>((ref) {
  final dio = ref.watch(dioClientProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  final launchDao = ref.watch(launchDaoProvider);
  return LaunchDetailService(dio, networkInfo, launchDao);
});

/// Servicio para obtener detalles de lanzamiento
class LaunchDetailService {
  LaunchDetailService(this._dio, this._networkInfo, this._launchDao);

  final Dio _dio;
  final NetworkInfo _networkInfo;
  final LaunchDao _launchDao;

  /// Obtiene un lanzamiento por ID
  Future<LaunchModel> getLaunchById(String id) async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _dio.get('${ApiConstants.launches}/$id');
        final launch = LaunchModel.fromJson(response.data as Map<String, dynamic>);

        // Resolver nombres de cohete y launchpad
        String? rocketName;
        String? launchpadName;

        if (launch.rocket != null) {
          try {
            final rocketResponse = await _dio.get('${ApiConstants.rockets}/${launch.rocket}');
            rocketName = rocketResponse.data['name'] as String?;
          } catch (_) {}
        }

        if (launch.launchpad != null) {
          try {
            final launchpadResponse = await _dio.get('${ApiConstants.launchpads}/${launch.launchpad}');
            launchpadName = launchpadResponse.data['name'] as String?;
          } catch (_) {}
        }

        return launch.copyWith(
          rocketName: rocketName,
          launchpadName: launchpadName,
        );
      } else {
        return await _getFromCache(id);
      }
    } on DioException catch (e) {
      // Intentar obtener de caché en caso de error
      try {
        return await _getFromCache(id);
      } catch (_) {
        if (e.error is AppException) {
          throw e.error as AppException;
        }
        throw NetworkException(
          message: 'Error al obtener lanzamiento: ${e.message}',
          code: 'FETCH_ERROR',
        );
      }
    } catch (e) {
      // Intentar caché como fallback
      try {
        return await _getFromCache(id);
      } catch (_) {
        throw NetworkException(
          message: 'Error inesperado: ${e.toString()}',
          code: 'UNEXPECTED_ERROR',
        );
      }
    }
  }

  /// Obtiene lanzamiento de caché
  Future<LaunchModel> _getFromCache(String id) async {
    final cached = await _launchDao.getLaunchById(id);
    if (cached == null) {
      throw const NotFoundException(
        message: 'Lanzamiento no encontrado en caché',
      );
    }
    return _mapFromDatabase(cached);
  }

  /// Convierte registro de BD a LaunchModel
  LaunchModel _mapFromDatabase(Launch dbLaunch) {
    return LaunchModel(
      id: dbLaunch.id,
      name: dbLaunch.name,
      success: dbLaunch.success == null ? null : dbLaunch.success == 1,
      flightNumber: dbLaunch.flightNumber,
      details: dbLaunch.details,
      dateUtc: dbLaunch.dateUtc,
      links: LaunchLinks(
        patch: LaunchPatch(
          small: dbLaunch.patchSmall,
          large: dbLaunch.patchLarge,
        ),
        webcast: dbLaunch.webcast,
        wikipedia: dbLaunch.wikipedia,
        article: dbLaunch.article,
        flickr: LaunchFlickr(
          original: dbLaunch.flickrImages.split(',').where((e) => e.isNotEmpty).toList(),
        ),
      ),
      rocket: dbLaunch.rocket,
      launchpad: dbLaunch.launchpad,
      rocketName: dbLaunch.rocketName,
      launchpadName: dbLaunch.launchpadName,
    );
  }
}
