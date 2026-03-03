import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/themes/color_tokens.dart';
import '../../../../config/themes/theme_provider.dart';

/// Widget para seleccionar el tema de la aplicación
class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeModeProvider);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.palette_outlined,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Text(
                'settings.theme'.tr(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _ThemeOption(
                icon: Icons.light_mode,
                label: 'settings.theme_light'.tr(),
                isSelected: currentTheme == ThemeMode.light,
                onTap: () {
                  HapticFeedback.selectionClick();
                  ref.read(themeModeProvider.notifier).setTheme(ThemeMode.light);
                },
              ),
              const SizedBox(width: 12),
              _ThemeOption(
                icon: Icons.dark_mode,
                label: 'settings.theme_dark'.tr(),
                isSelected: currentTheme == ThemeMode.dark,
                onTap: () {
                  HapticFeedback.selectionClick();
                  ref.read(themeModeProvider.notifier).setTheme(ThemeMode.dark);
                },
              ),
              const SizedBox(width: 12),
              _ThemeOption(
                icon: Icons.settings_suggest,
                label: 'settings.theme_system'.tr(),
                isSelected: currentTheme == ThemeMode.system,
                onTap: () {
                  HapticFeedback.selectionClick();
                  ref.read(themeModeProvider.notifier).setTheme(ThemeMode.system);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? ColorTokens.portalGreen.withValues(alpha: 0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? ColorTokens.portalGreen
                  : theme.colorScheme.outline.withValues(alpha: 0.3),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? ColorTokens.portalGreen
                    : theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: isSelected
                      ? ColorTokens.portalGreen
                      : theme.colorScheme.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
