import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/controller/auth_controller.dart';
import '../../features/auth/models/user.dart';
import '../../features/auth/ui/login_screen.dart';
import '../../features/detail/ui/launch_detail_screen.dart';
import '../../features/home/ui/home_screen.dart';
import '../../features/profile/ui/profile_screen.dart';
import '../../features/splash/ui/splash_screen.dart';
import 'routes.dart';
import 'transitions.dart';

/// Notifier para refrescar el router cuando cambia el estado de auth
class AuthNotifier extends ChangeNotifier {
  AuthNotifier(this._ref) {
    _ref.listen<AuthState>(authControllerProvider, (_, __) {
      notifyListeners();
    });
  }

  final Ref _ref;

  bool get isAuthenticated {
    final state = _ref.read(authControllerProvider);
    return state is Authenticated;
  }
}

/// Provider para el notifier de autenticación
final authNotifierProvider = Provider<AuthNotifier>((ref) {
  return AuthNotifier(ref);
});

/// Provider para el router de la aplicación
final appRouterProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: Routes.splash,
    debugLogDiagnostics: true,
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final isAuthenticated = authNotifier.isAuthenticated;

      final isLoginRoute = state.matchedLocation == Routes.login;
      final isSplashRoute = state.matchedLocation == Routes.splash;

      // No redirigir si estamos en el splash (deja que el splash maneje la navegación)
      if (isSplashRoute) return null;

      // Si está autenticado y en login, redirigir a home
      if (isAuthenticated && isLoginRoute) {
        return Routes.home;
      }

      // Si no está autenticado y no está en login, redirigir a login
      if (!isAuthenticated && !isLoginRoute) {
        return Routes.login;
      }

      return null;
    },
    routes: [
      // Splash / Inicio
      GoRoute(
        path: Routes.splash,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
          transitionsBuilder: fadeTransition,
        ),
      ),

      // Login
      GoRoute(
        path: Routes.login,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginScreen(),
          transitionsBuilder: fadeTransition,
        ),
      ),

      // Home
      GoRoute(
        path: Routes.home,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
          transitionsBuilder: fadeTransition,
        ),
      ),

      // Detalle de lanzamiento
      GoRoute(
        path: '${Routes.detail}/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return CustomTransitionPage(
            key: state.pageKey,
            child: LaunchDetailScreen(launchId: id),
            transitionsBuilder: slideUpTransition,
          );
        },
      ),

      // Perfil
      GoRoute(
        path: Routes.profile,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ProfileScreen(),
          transitionsBuilder: slideTransition,
        ),
      ),
    ],

    // Manejo de errores
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64),
              const SizedBox(height: 16),
              Text(
                'Página no encontrada',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(state.error?.message ?? ''),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go(Routes.home),
                child: const Text('Volver al inicio'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
});
