/// Clase con utilidades de validación
class Validators {
  Validators._();

  /// Valida que el email tenga formato correcto
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El correo electrónico es requerido';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Ingresa un correo electrónico válido';
    }

    return null;
  }

  /// Valida que el nombre de usuario sea válido
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'El nombre de usuario es requerido';
    }

    if (value.length < 3) {
      return 'El nombre de usuario debe tener al menos 3 caracteres';
    }

    if (value.length > 20) {
      return 'El nombre de usuario no puede exceder 20 caracteres';
    }

    return null;
  }

  /// Valida la contraseña según los requisitos de seguridad
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }

    final requirements = getPasswordRequirements(value);
    final unmet = requirements.entries
        .where((e) => !e.value)
        .map((e) => e.key)
        .toList();

    if (unmet.isNotEmpty) {
      return 'La contraseña no cumple con los requisitos';
    }

    return null;
  }

  /// Obtiene el estado de cada requisito de contraseña
  static Map<String, bool> getPasswordRequirements(String password) {
    return {
      'Mínimo 8 caracteres': password.length >= 8,
      'Al menos una mayúscula': RegExp(r'[A-Z]').hasMatch(password),
      'Al menos una minúscula': RegExp(r'[a-z]').hasMatch(password),
      'Al menos un número': RegExp(r'[0-9]').hasMatch(password),
      'Al menos un carácter especial': RegExp(r'[!@#$%^&*(),.?":{}|<>]')
          .hasMatch(password),
    };
  }

  /// Verifica si la contraseña es válida
  static bool isPasswordValid(String password) {
    final requirements = getPasswordRequirements(password);
    return requirements.values.every((met) => met);
  }

  /// Valida que la confirmación de contraseña coincida
  static String? validatePasswordConfirmation(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirma tu contraseña';
    }

    if (value != password) {
      return 'Las contraseñas no coinciden';
    }

    return null;
  }

  /// Valida que un campo no esté vacío
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName es requerido';
    }
    return null;
  }
}
