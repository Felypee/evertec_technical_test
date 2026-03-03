import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/launch.dart';
import '../service/launch_service.dart';

/// Estado de filtros aplicados
class LaunchFilters {
  const LaunchFilters({
    this.status,
    this.rocket,
    this.searchQuery,
  });

  final String? status;
  final String? rocket;
  final String? searchQuery;

  LaunchFilters copyWith({
    String? status,
    String? rocket,
    String? searchQuery,
    bool clearStatus = false,
    bool clearRocket = false,
    bool clearSearch = false,
  }) {
    return LaunchFilters(
      status: clearStatus ? null : (status ?? this.status),
      rocket: clearRocket ? null : (rocket ?? this.rocket),
      searchQuery: clearSearch ? null : (searchQuery ?? this.searchQuery),
    );
  }

  bool get hasFilters =>
      status != null || rocket != null || (searchQuery?.isNotEmpty ?? false);
}

/// Provider para los filtros actuales
final launchFiltersProvider =
    StateProvider<LaunchFilters>((ref) => const LaunchFilters());

/// Provider para el controlador de lanzamientos
final launchControllerProvider =
    AsyncNotifierProvider<LaunchController, List<LaunchModel>>(
  LaunchController.new,
);

/// Provider para el lanzamiento seleccionado
final selectedLaunchProvider = StateProvider<LaunchModel?>((ref) => null);

/// Controlador de lanzamientos con AsyncNotifier
class LaunchController extends AsyncNotifier<List<LaunchModel>> {
  LaunchService get _service => ref.read(launchServiceProvider);

  @override
  Future<List<LaunchModel>> build() async {
    return await _service.getAllLaunches();
  }

  /// Refresca la lista de lanzamientos
  Future<void> refresh({
    VoidCallback? onSuccess,
    Function(String)? onError,
  }) async {
    state = const AsyncLoading();

    try {
      final launches = await _service.getAllLaunches();
      state = AsyncData(launches);
      onSuccess?.call();
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      onError?.call(e.toString());
    }
  }

  /// Busca lanzamientos por nombre
  Future<void> search(
    String query, {
    VoidCallback? onSuccess,
    Function(String)? onError,
  }) async {
    if (query.isEmpty) {
      await refresh(onSuccess: onSuccess, onError: onError);
      return;
    }

    state = const AsyncLoading();

    try {
      final launches = await _service.searchLaunches(query);
      state = AsyncData(launches);
      onSuccess?.call();
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      onError?.call(e.toString());
    }
  }

  /// Filtra lanzamientos por estado
  Future<void> filterByStatus(
    String status, {
    VoidCallback? onSuccess,
    Function(String)? onError,
  }) async {
    state = const AsyncLoading();

    try {
      final launches = await _service.filterByStatus(status);
      state = AsyncData(launches);
      onSuccess?.call();
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      onError?.call(e.toString());
    }
  }

  /// Filtra lanzamientos por cohete
  Future<void> filterByRocket(
    String rocket, {
    VoidCallback? onSuccess,
    Function(String)? onError,
  }) async {
    state = const AsyncLoading();

    try {
      final launches = await _service.filterByRocket(rocket);
      state = AsyncData(launches);
      onSuccess?.call();
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      onError?.call(e.toString());
    }
  }

  /// Aplica los filtros actuales
  Future<void> applyFilters(
    LaunchFilters filters, {
    VoidCallback? onSuccess,
    Function(String)? onError,
  }) async {
    // Prioridad: búsqueda > estado > cohete
    if (filters.searchQuery?.isNotEmpty ?? false) {
      await search(filters.searchQuery!, onSuccess: onSuccess, onError: onError);
    } else if (filters.status != null) {
      await filterByStatus(filters.status!, onSuccess: onSuccess, onError: onError);
    } else if (filters.rocket != null) {
      await filterByRocket(filters.rocket!, onSuccess: onSuccess, onError: onError);
    } else {
      await refresh(onSuccess: onSuccess, onError: onError);
    }
  }

  /// Limpia todos los filtros
  Future<void> clearFilters({
    VoidCallback? onSuccess,
    Function(String)? onError,
  }) async {
    ref.read(launchFiltersProvider.notifier).state = const LaunchFilters();
    await refresh(onSuccess: onSuccess, onError: onError);
  }
}

/// Provider para los cohetes únicos disponibles
final uniqueRocketsProvider = FutureProvider<List<String>>((ref) async {
  final service = ref.watch(launchServiceProvider);
  return await service.getUniqueRockets();
});
