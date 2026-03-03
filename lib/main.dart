import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/routes/app_router.dart';
import 'config/themes/app_theme.dart';
import 'config/themes/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar easy_localization
  await EasyLocalization.ensureInitialized();

  // Configurar orientación preferida
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('es'),
      child: const ProviderScope(
        child: SpaceXLaunchesApp(),
      ),
    ),
  );
}

/// Aplicación principal de SpaceX Launches
class SpaceXLaunchesApp extends ConsumerWidget {
  const SpaceXLaunchesApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      // Configuración básica
      title: 'SpaceX Launches',
      debugShowCheckedModeBanner: false,

      // Temas
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      // Internacionalización
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      // Router
      routerConfig: router,
    );
  }
}
