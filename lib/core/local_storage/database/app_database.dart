import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

/// Tabla de lanzamientos para caché local
@DataClassName('Launch')
class Launches extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get success => integer().nullable()(); // null = upcoming, 0 = failed, 1 = success
  IntColumn get flightNumber => integer()();
  TextColumn get details => text().nullable()();
  TextColumn get dateUtc => text()();
  TextColumn get patchSmall => text().nullable()();
  TextColumn get patchLarge => text().nullable()();
  TextColumn get webcast => text().nullable()();
  TextColumn get wikipedia => text().nullable()();
  TextColumn get article => text().nullable()();
  TextColumn get flickrImages => text().withDefault(const Constant(''))(); // JSON array como string
  TextColumn get rocket => text().nullable()();
  TextColumn get launchpad => text().nullable()();
  TextColumn get rocketName => text().nullable()();
  TextColumn get launchpadName => text().nullable()();
  DateTimeColumn get cachedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Base de datos de la aplicación con Drift
@DriftDatabase(tables: [Launches])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Migración de v1 a v2 (SpaceX Launches)
        if (from < 2) {
          // Eliminar tabla antigua si existe
          await m.deleteTable('characters');
          // Crear nueva tabla de lanzamientos
          await m.createAll();
        }
      },
    );
  }
}

/// Abre la conexión a la base de datos
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'spacex.db'));
    return NativeDatabase.createInBackground(file);
  });
}

/// Provider para la base de datos
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(() => database.close());
  return database;
});
