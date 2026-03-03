import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../home/models/launch.dart';
import '../service/launch_detail_service.dart';

/// Provider para el controlador de detalle de lanzamiento
final launchDetailControllerProvider = AsyncNotifierProvider.family<
    LaunchDetailController, LaunchModel, String>(
  LaunchDetailController.new,
);

/// Controlador para el detalle de lanzamiento
class LaunchDetailController extends FamilyAsyncNotifier<LaunchModel, String> {
  LaunchDetailService get _service =>
      ref.read(launchDetailServiceProvider);

  @override
  Future<LaunchModel> build(String arg) async {
    return await _service.getLaunchById(arg);
  }

  /// Refresca el lanzamiento
  Future<void> refresh({
    VoidCallback? onSuccess,
    Function(String)? onError,
  }) async {
    state = const AsyncLoading();

    try {
      final launch = await _service.getLaunchById(arg);
      state = AsyncData(launch);
      onSuccess?.call();
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      onError?.call(e.toString());
    }
  }
}
