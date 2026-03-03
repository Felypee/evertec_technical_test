import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/constants/api_constants.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/local_storage/database/app_database.dart';
import '../../../core/local_storage/database/daos/launch_dao.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/network_info.dart';
import '../models/launch.dart';

/// Provider para el servicio de lanzamientos
final launchServiceProvider = Provider<LaunchService>((ref) {
  final dio = ref.watch(dioClientProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  final launchDao = ref.watch(launchDaoProvider);
  return LaunchService(dio, networkInfo, launchDao);
});

/// Servicio para obtener lanzamientos con estrategia offline-first
class LaunchService {
  LaunchService(this._dio, this._networkInfo, this._launchDao);

  final Dio _dio;
  final NetworkInfo _networkInfo;
  final LaunchDao _launchDao;

  // Cache para nombres de cohetes y launchpads
  Map<String, String>? _rocketNames;
  Map<String, String>? _launchpadNames;

  /// Obtiene todos los lanzamientos (offline-first)
  Future<List<LaunchModel>> getAllLaunches() async {
    try {
      if (await _networkInfo.isConnected) {
        // Obtener datos de la API
        final response = await _dio.get(ApiConstants.launches);
        final launchesData = response.data as List<dynamic>;

        // Cargar nombres de cohetes y launchpads
        await _loadRocketAndLaunchpadNames();

        // Mapear a modelos con nombres resueltos
        final launches = launchesData.map((json) {
          final launch = LaunchModel.fromJson(json as Map<String, dynamic>);
          return launch.copyWith(
            rocketName: _rocketNames?[launch.rocket],
            launchpadName: _launchpadNames?[launch.launchpad],
          );
        }).toList();

        // Ordenar: primero los que tienen enlaces (especialmente video), luego por fecha
        launches.sort((a, b) {
          // Primero comparar por cantidad de enlaces (más enlaces = primero)
          final linkComparison = b.linkCount.compareTo(a.linkCount);
          if (linkComparison != 0) return linkComparison;
          // Si tienen los mismos enlaces, ordenar por fecha (más reciente primero)
          return b.dateUtc.compareTo(a.dateUtc);
        });

        // Guardar en caché
        await _cacheLaunches(launches);

        return launches;
      } else {
        // Sin conexión, obtener de caché
        return await _getFromCache();
      }
    } on DioException catch (e) {
      // En caso de error de red, intentar obtener de caché
      final cached = await _getFromCache();
      if (cached.isNotEmpty) {
        return cached;
      }

      // Si no hay caché, lanzar excepción
      if (e.error is AppException) {
        throw e.error as AppException;
      }
      throw NetworkException(
        message: 'Error al obtener lanzamientos: ${e.message}',
        code: 'FETCH_ERROR',
      );
    } catch (e) {
      // Intentar obtener de caché como fallback
      final cached = await _getFromCache();
      if (cached.isNotEmpty) {
        return cached;
      }

      throw NetworkException(
        message: 'Error inesperado: ${e.toString()}',
        code: 'UNEXPECTED_ERROR',
      );
    }
  }

  /// Carga los nombres de cohetes y launchpads
  Future<void> _loadRocketAndLaunchpadNames() async {
    try {
      // Cargar cohetes si no están cacheados
      if (_rocketNames == null) {
        final rocketsResponse = await _dio.get(ApiConstants.rockets);
        final rockets = rocketsResponse.data as List<dynamic>;
        _rocketNames = {
          for (final r in rockets) r['id'] as String: r['name'] as String
        };
      }

      // Cargar launchpads si no están cacheados
      if (_launchpadNames == null) {
        final launchpadsResponse = await _dio.get(ApiConstants.launchpads);
        final launchpads = launchpadsResponse.data as List<dynamic>;
        _launchpadNames = {
          for (final l in launchpads) l['id'] as String: l['name'] as String
        };
      }
    } catch (e) {
      // Ignorar errores de carga de nombres, usar IDs como fallback
    }
  }

  /// Busca lanzamientos por nombre
  Future<List<LaunchModel>> searchLaunches(String query) async {
    try {
      if (await _networkInfo.isConnected) {
        // La API de SpaceX no tiene búsqueda, filtrar localmente
        final launches = await getAllLaunches();
        return launches
            .where((l) => l.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        // Buscar en caché local
        return await _searchInCache(query);
      }
    } catch (e) {
      return await _searchInCache(query);
    }
  }

  /// Filtra lanzamientos por estado
  Future<List<LaunchModel>> filterByStatus(String status) async {
    try {
      if (await _networkInfo.isConnected) {
        final launches = await getAllLaunches();
        return launches.where((l) {
          switch (status.toLowerCase()) {
            case 'success':
              return l.success == true;
            case 'failed':
              return l.success == false;
            case 'upcoming':
              return l.success == null;
            default:
              return true;
          }
        }).toList();
      } else {
        return await _filterInCacheByStatus(status);
      }
    } catch (e) {
      return await _filterInCacheByStatus(status);
    }
  }

  /// Filtra lanzamientos por cohete
  Future<List<LaunchModel>> filterByRocket(String rocketName) async {
    try {
      if (await _networkInfo.isConnected) {
        final launches = await getAllLaunches();
        return launches.where((l) => l.rocketName == rocketName).toList();
      } else {
        return await _filterInCacheByRocket(rocketName);
      }
    } catch (e) {
      return await _filterInCacheByRocket(rocketName);
    }
  }

  /// Obtiene lanzamientos del caché local
  Future<List<LaunchModel>> _getFromCache() async {
    try {
      final cached = await _launchDao.getAllLaunches();
      return cached.map(_mapFromDatabase).toList();
    } catch (e) {
      throw const CacheException(
        message: 'Error al leer caché local',
        code: 'CACHE_READ_ERROR',
      );
    }
  }

  /// Busca en caché local
  Future<List<LaunchModel>> _searchInCache(String query) async {
    try {
      final cached = await _launchDao.searchByName(query);
      return cached.map(_mapFromDatabase).toList();
    } catch (e) {
      return [];
    }
  }

  /// Filtra en caché por estado
  Future<List<LaunchModel>> _filterInCacheByStatus(String status) async {
    try {
      final cached = await _launchDao.filterBySuccess(status);
      return cached.map(_mapFromDatabase).toList();
    } catch (e) {
      return [];
    }
  }

  /// Filtra en caché por cohete
  Future<List<LaunchModel>> _filterInCacheByRocket(String rocketName) async {
    try {
      final cached = await _launchDao.filterByRocket(rocketName);
      return cached.map(_mapFromDatabase).toList();
    } catch (e) {
      return [];
    }
  }

  /// Guarda lanzamientos en caché
  Future<void> _cacheLaunches(List<LaunchModel> launches) async {
    try {
      final companions = launches.map(_mapToDatabase).toList();
      await _launchDao.insertLaunches(companions);
    } catch (e) {
      // Error silencioso en caché - no interrumpir flujo principal
    }
  }

  /// Convierte LaunchModel a LaunchesCompanion para la BD
  LaunchesCompanion _mapToDatabase(LaunchModel launch) {
    return LaunchesCompanion(
      id: Value(launch.id),
      name: Value(launch.name),
      success: Value(launch.success == null ? null : (launch.success! ? 1 : 0)),
      flightNumber: Value(launch.flightNumber),
      details: Value(launch.details),
      dateUtc: Value(launch.dateUtc),
      patchSmall: Value(launch.links.patch?.small),
      patchLarge: Value(launch.links.patch?.large),
      webcast: Value(launch.links.webcast),
      wikipedia: Value(launch.links.wikipedia),
      article: Value(launch.links.article),
      flickrImages: Value(launch.flickrImages.join(',')),
      rocket: Value(launch.rocket),
      launchpad: Value(launch.launchpad),
      rocketName: Value(launch.rocketName),
      launchpadName: Value(launch.launchpadName),
    );
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

  /// Obtiene los nombres de cohetes únicos para filtros
  Future<List<String>> getUniqueRockets() async {
    try {
      final rockets = await _launchDao.getUniqueRockets();
      if (rockets.isNotEmpty) {
        return rockets;
      }
      // Valores por defecto
      return ['Falcon 1', 'Falcon 9', 'Falcon Heavy', 'Starship'];
    } catch (e) {
      return ['Falcon 1', 'Falcon 9', 'Falcon Heavy', 'Starship'];
    }
  }

  /// Verifica si hay datos en caché
  Future<bool> hasCache() async {
    return await _launchDao.hasCache();
  }
}
