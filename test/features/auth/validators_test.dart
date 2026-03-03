import 'package:flutter_test/flutter_test.dart';
import 'package:evertec_technical_test/core/utils/validators.dart';

void main() {
  group('Validators', () {
    group('validatePassword', () {
      test('debe retornar error cuando la contraseña está vacía', () {
        final result = Validators.validatePassword('');
        expect(result, isNotNull);
        expect(result, contains('requerida'));
      });

      test('debe retornar error cuando la contraseña es muy corta', () {
        final result = Validators.validatePassword('Abc1!');
        expect(result, isNotNull);
      });

      test('debe retornar null cuando la contraseña es válida', () {
        final result = Validators.validatePassword('Secure123!');
        expect(result, isNull);
      });

      test('debe retornar error cuando falta mayúscula', () {
        final result = Validators.validatePassword('secure123!');
        expect(result, isNotNull);
      });

      test('debe retornar error cuando falta número', () {
        final result = Validators.validatePassword('Securepassword!');
        expect(result, isNotNull);
      });

      test('debe retornar error cuando falta carácter especial', () {
        final result = Validators.validatePassword('Secure123');
        expect(result, isNotNull);
      });
    });

    group('getPasswordRequirements', () {
      test('debe indicar todos los requisitos cumplidos para contraseña válida', () {
        final requirements = Validators.getPasswordRequirements('Secure123!');
        expect(requirements.values.every((met) => met), isTrue);
      });

      test('debe indicar requisito de longitud no cumplido', () {
        final requirements = Validators.getPasswordRequirements('Abc1!');
        expect(requirements['Mínimo 8 caracteres'], isFalse);
      });

      test('debe indicar requisito de mayúscula no cumplido', () {
        final requirements = Validators.getPasswordRequirements('secure123!');
        expect(requirements['Al menos una mayúscula'], isFalse);
      });

      test('debe indicar requisito de número no cumplido', () {
        final requirements = Validators.getPasswordRequirements('Securepass!');
        expect(requirements['Al menos un número'], isFalse);
      });
    });

    group('isPasswordValid', () {
      test('debe retornar true para contraseña válida', () {
        expect(Validators.isPasswordValid('Secure123!'), isTrue);
      });

      test('debe retornar false para contraseña inválida', () {
        expect(Validators.isPasswordValid('weak'), isFalse);
      });
    });

    group('validateUsername', () {
      test('debe retornar error cuando el nombre de usuario está vacío', () {
        final result = Validators.validateUsername('');
        expect(result, isNotNull);
        expect(result, contains('requerido'));
      });

      test('debe retornar error cuando es muy corto', () {
        final result = Validators.validateUsername('ab');
        expect(result, isNotNull);
        expect(result, contains('al menos 3'));
      });

      test('debe retornar error cuando es muy largo', () {
        final result = Validators.validateUsername('a' * 21);
        expect(result, isNotNull);
        expect(result, contains('no puede exceder'));
      });

      test('debe retornar null para nombre de usuario válido', () {
        final result = Validators.validateUsername('usuario123');
        expect(result, isNull);
      });
    });

    group('validateEmail', () {
      test('debe retornar error para email vacío', () {
        final result = Validators.validateEmail('');
        expect(result, isNotNull);
      });

      test('debe retornar error para email inválido', () {
        final result = Validators.validateEmail('invalid-email');
        expect(result, isNotNull);
        expect(result, contains('válido'));
      });

      test('debe retornar null para email válido', () {
        final result = Validators.validateEmail('test@example.com');
        expect(result, isNull);
      });
    });
  });
}
