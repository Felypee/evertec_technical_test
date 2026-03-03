import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/routes/routes.dart';
import '../../../config/themes/color_tokens.dart';
import '../../../core/providers/package_info_provider.dart';
import '../../auth/controller/auth_controller.dart';
import '../../auth/models/user.dart';
import 'widgets/confirm_logout_dialog.dart';
import 'widgets/language_selector.dart';
import 'widgets/theme_selector.dart';

/// Pantalla de perfil con configuraciones
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _handleLogout(BuildContext context, WidgetRef ref) async {
    HapticFeedback.mediumImpact();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => const ConfirmLogoutDialog(),
    );

    if (confirmed == true && context.mounted) {
      await ref.read(authControllerProvider.notifier).logout(
        onSuccess: () {
          HapticFeedback.heavyImpact();
          context.go(Routes.login);
        },
        onError: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error),
              backgroundColor: ColorTokens.error,
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authControllerProvider);

    final username = switch (authState) {
      Authenticated(:final user) => user.username,
      _ => 'profile.user'.tr(),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('profile.title'.tr()),
        leading: IconButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar y nombre
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ColorTokens.portalGreen,
                          ColorTokens.portalGreenLight,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: ColorTokens.portalGreen.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        username.isNotEmpty ? username[0].toUpperCase() : 'U',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    username,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'profile.welcome'.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms)
                .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),

            const SizedBox(height: 32),

            // Sección de apariencia
            Text(
              'profile.appearance'.tr(),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

            const SizedBox(height: 16),

            // Selector de tema
            const ThemeSelector()
                .animate()
                .fadeIn(delay: 300.ms, duration: 400.ms)
                .slideX(begin: -0.1, end: 0),

            const SizedBox(height: 16),

            // Selector de idioma
            const LanguageSelector()
                .animate()
                .fadeIn(delay: 400.ms, duration: 400.ms)
                .slideX(begin: -0.1, end: 0),

            const SizedBox(height: 32),

            // Sección de cuenta
            Text(
              'profile.account'.tr(),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(delay: 500.ms, duration: 400.ms),

            const SizedBox(height: 16),

            // Botón de cerrar sesión
            _buildMenuItem(
              context,
              icon: Icons.logout,
              title: 'profile.logout'.tr(),
              subtitle: 'profile.logout_description'.tr(),
              onTap: () => _handleLogout(context, ref),
              isDestructive: true,
            )
                .animate()
                .fadeIn(delay: 600.ms, duration: 400.ms)
                .slideX(begin: -0.1, end: 0),

            const SizedBox(height: 32),

            // Información de la app
            Center(
              child: Column(
                children: [
                  Text(
                    'app.name'.tr(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _AppVersionText(theme: theme),
                ],
              ),
            ).animate().fadeIn(delay: 700.ms, duration: 400.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final theme = Theme.of(context);
    final color = isDestructive ? ColorTokens.error : theme.colorScheme.primary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: color.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget para mostrar la versión de la app dinámicamente
class _AppVersionText extends ConsumerWidget {
  const _AppVersionText({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfoAsync = ref.watch(packageInfoProvider);

    return packageInfoAsync.when(
      data: (info) => Text(
        'v${info.version} (${info.buildNumber})',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.outline,
        ),
      ),
      loading: () => Text(
        '...',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.outline,
        ),
      ),
      error: (_, __) => Text(
        'v?.?.?',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.outline,
        ),
      ),
    );
  }
}
