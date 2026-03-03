import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/routes/routes.dart';
import '../../../config/themes/color_tokens.dart';
import '../../../core/utils/validators.dart';
import '../controller/auth_controller.dart';
import 'widgets/password_requirements_widget.dart';

/// Pantalla de inicio de sesión
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      HapticFeedback.lightImpact();
      return;
    }

    setState(() => _isLoading = true);
    HapticFeedback.mediumImpact();

    await ref.read(authControllerProvider.notifier).login(
          username: _usernameController.text.trim(),
          password: _passwordController.text,
          onSuccess: () {
            if (!mounted) return;
            HapticFeedback.heavyImpact();
            context.go(Routes.home);
          },
          onError: (error) {
            if (!mounted) return;
            HapticFeedback.lightImpact();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error),
                backgroundColor: ColorTokens.error,
              ),
            );
          },
        );

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo o imagen
                  Icon(
                    Icons.auto_awesome,
                    size: 80,
                    color: ColorTokens.portalGreen,
                  )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .scale(delay: 200.ms, duration: 400.ms),

                  const SizedBox(height: 24),

                  // Título
                  Text(
                    'login.welcome'.tr(),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .fadeIn(delay: 200.ms, duration: 500.ms)
                      .slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 8),

                  // Subtítulo
                  Text(
                    'login.subtitle'.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 500.ms)
                      .slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 48),

                  // Campo de usuario
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'login.username'.tr(),
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: Validators.validateUsername,
                    enabled: !_isLoading,
                  )
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 500.ms)
                      .slideX(begin: -0.1, end: 0),

                  const SizedBox(height: 16),

                  // Campo de contraseña
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'login.password'.tr(),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),
                    ),
                    obscureText: _obscurePassword,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _handleLogin(),
                    validator: Validators.validatePassword,
                    enabled: !_isLoading,
                    onChanged: (_) => setState(() {}),
                  )
                      .animate()
                      .fadeIn(delay: 500.ms, duration: 500.ms)
                      .slideX(begin: 0.1, end: 0),

                  const SizedBox(height: 16),

                  // Requisitos de contraseña
                  PasswordRequirementsWidget(
                    password: _passwordController.text,
                  ).animate().fadeIn(delay: 600.ms, duration: 500.ms),

                  const SizedBox(height: 32),

                  // Botón de login
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      child: _isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : Text(
                              'login.button'.tr(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 700.ms, duration: 500.ms)
                      .slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 24),

                  // Nota sobre primer login
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ColorTokens.portalGreen.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: ColorTokens.portalGreen.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: ColorTokens.portalGreen,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'login.first_time_note'.tr(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 800.ms, duration: 500.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
