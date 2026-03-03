import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../config/themes/color_tokens.dart';
import '../../../../core/utils/validators.dart';

/// Widget que muestra los requisitos de contraseña
class PasswordRequirementsWidget extends StatelessWidget {
  const PasswordRequirementsWidget({
    super.key,
    required this.password,
  });

  final String password;

  @override
  Widget build(BuildContext context) {
    final requirements = Validators.getPasswordRequirements(password);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'login.password_requirements'.tr(),
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        ...requirements.entries.map((entry) {
          final isValid = entry.value;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isValid
                        ? ColorTokens.statusAlive
                        : Colors.transparent,
                    border: Border.all(
                      color: isValid
                          ? ColorTokens.statusAlive
                          : theme.colorScheme.outline,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: isValid
                      ? const Icon(
                          Icons.check,
                          size: 14,
                          color: Colors.white,
                        )
                          .animate()
                          .scale(
                            begin: const Offset(0, 0),
                            end: const Offset(1, 1),
                            duration: 200.ms,
                          )
                      : null,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _translateRequirement(entry.key),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isValid
                          ? ColorTokens.statusAlive
                          : theme.colorScheme.onSurfaceVariant,
                      decoration: isValid
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  /// Traduce los requisitos de contraseña
  String _translateRequirement(String requirement) {
    switch (requirement) {
      case 'Mínimo 8 caracteres':
        return 'password.min_chars'.tr();
      case 'Al menos una mayúscula':
        return 'password.uppercase'.tr();
      case 'Al menos una minúscula':
        return 'password.lowercase'.tr();
      case 'Al menos un número':
        return 'password.number'.tr();
      case 'Al menos un carácter especial':
        return 'password.special'.tr();
      default:
        return requirement;
    }
  }
}
