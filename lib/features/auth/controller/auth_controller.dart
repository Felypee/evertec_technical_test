import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../service/auth_service.dart';

/// Provider para el controlador de autenticación
final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthController(authService);
});

/// Provider para verificar si el usuario está autenticado
final isAuthenticatedProvider = FutureProvider<bool>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.isAuthenticated();
});

/// Controlador de autenticación
class AuthController extends StateNotifier<AuthState> {
  AuthController(this._authService) : super(const AuthState.unauthenticated()) {
    _checkAuthStatus();
  }

  final AuthService _authService;

  /// Verifica el estado de autenticación al iniciar
  Future<void> _checkAuthStatus() async {
    final user = await _authService.getCurrentUser();
    if (user != null) {
      state = AuthState.authenticated(user);
    }
  }

  /// Intenta iniciar sesión
  Future<void> login({
    required String username,
    required String password,
    VoidCallback? onSuccess,
    Function(String)? onError,
  }) async {
    state = const AuthState.loading();

    try {
      final user = await _authService.login(
        username: username,
        password: password,
      );
      state = AuthState.authenticated(user);
      onSuccess?.call();
    } catch (e) {
      final errorMessage = e.toString().replaceAll('AuthException: ', '');
      state = AuthState.error(errorMessage);
      onError?.call(errorMessage);
    }
  }

  /// Cierra la sesión
  Future<void> logout({
    VoidCallback? onSuccess,
    Function(String)? onError,
  }) async {
    state = const AuthState.loading();

    try {
      await _authService.logout();
      state = const AuthState.unauthenticated();
      onSuccess?.call();
    } catch (e) {
      final errorMessage = e.toString();
      state = AuthState.error(errorMessage);
      onError?.call(errorMessage);
    }
  }

  /// Reinicia el estado de error
  void clearError() {
    if (state is AuthError) {
      state = const AuthState.unauthenticated();
    }
  }

  /// Verifica si el usuario está autenticado actualmente
  bool get isAuthenticated {
    return state is Authenticated;
  }

  /// Obtiene el usuario actual si está autenticado
  User? get currentUser {
    return switch (state) {
      Authenticated(:final user) => user,
      _ => null,
    };
  }
}
