import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app_database.dart';

part 'launch_dao.g.dart';

/// Provider para el DAO de lanzamientos
final launchDaoProvider = Provider<LaunchDao>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return LaunchDao(database);
});

/// DAO para operaciones CRUD de lanzamientos
@DriftAccessor(tables: [Launches])
class LaunchDao extends DatabaseAccessor<AppDatabase> with _$LaunchDaoMixin {
  LaunchDao(super.db);

  /// Obtiene todos los lanzamientos ordenados por fecha (más reciente primero)
  Future<List<Launch>> getAllLaunches() {
    return (select(launches)
          ..orderBy([(t) => OrderingTerm.desc(t.dateUtc)]))
        .get();
  }

  /// Obtiene un lanzamiento por ID
  Future<Launch?> getLaunchById(String id) {
    return (select(launches)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// Busca lanzamientos por nombre
  Future<List<Launch>> searchByName(String query) {
    return (select(launches)
          ..where((t) => t.name.like('%$query%'))
          ..orderBy([(t) => OrderingTerm.desc(t.dateUtc)]))
        .get();
  }

  /// Filtra lanzamientos por estado de éxito
  /// status: 'Success' (success=1), 'Failed' (success=0), 'Upcoming' (success=null)
  Future<List<Launch>> filterBySuccess(String status) {
    return (select(launches)
          ..where((t) {
            switch (status.toLowerCase()) {
              case 'success':
                return t.success.equals(1);
              case 'failed':
                return t.success.equals(0);
              case 'upcoming':
                return t.success.isNull();
              default:
                return const Constant(true);
            }
          })
          ..orderBy([(t) => OrderingTerm.desc(t.dateUtc)]))
        .get();
  }

  /// Filtra lanzamientos por nombre de cohete
  Future<List<Launch>> filterByRocket(String rocketName) {
    return (select(launches)
          ..where((t) => t.rocketName.equals(rocketName))
          ..orderBy([(t) => OrderingTerm.desc(t.dateUtc)]))
        .get();
  }

  /// Inserta o actualiza un lanzamiento
  Future<void> insertLaunch(LaunchesCompanion launch) {
    return into(launches).insertOnConflictUpdate(launch);
  }

  /// Inserta o actualiza múltiples lanzamientos
  Future<void> insertLaunches(List<LaunchesCompanion> launchList) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(launches, launchList);
    });
  }

  /// Elimina un lanzamiento por ID
  Future<int> deleteLaunch(String id) {
    return (delete(launches)..where((t) => t.id.equals(id))).go();
  }

  /// Elimina todos los lanzamientos
  Future<int> deleteAllLaunches() {
    return delete(launches).go();
  }

  /// Obtiene el número total de lanzamientos en caché
  Future<int> getLaunchCount() async {
    final countExp = launches.id.count();
    final query = selectOnly(launches)..addColumns([countExp]);
    final result = await query.getSingle();
    return result.read(countExp) ?? 0;
  }

  /// Obtiene todos los nombres de cohetes únicos
  Future<List<String>> getUniqueRockets() async {
    final query = selectOnly(launches, distinct: true)
      ..addColumns([launches.rocketName])
      ..where(launches.rocketName.isNotNull());
    final results = await query.get();
    return results
        .map((row) => row.read(launches.rocketName))
        .whereType<String>()
        .toList();
  }

  /// Verifica si hay datos en caché
  Future<bool> hasCache() async {
    final count = await getLaunchCount();
    return count > 0;
  }
}
